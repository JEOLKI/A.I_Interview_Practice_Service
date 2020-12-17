package com.aiinterview.interview.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.xwpf.usermodel.LineSpacingRule;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.aiinterview.analysis.vo.TalentAnalysisVO;
import com.aiinterview.interview.service.KeywordService;
import com.aiinterview.interview.service.TalentService;
import com.aiinterview.interview.vo.KeywordVO;
import com.aiinterview.interview.vo.TalentVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/talent")
@Controller
public class TalentController {

	@Resource(name="talentService")
	private TalentService talentService;
	
	@Resource(name="keywordService")
	private KeywordService keywordService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/* 페이징 처리 */
	@RequestMapping("/retrievePagingList.do")
	public String retrievePagingList(TalentVO talentVO, String pageUnit, Model model) {
		
		int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
		model.addAttribute("pageUnit" , pageUnitInt);
		
		/** EgovPropertyService.sample */
		talentVO.setPageUnit(propertiesService.getInt("pageUnit"));
		talentVO.setPageSize(propertiesService.getInt("pageSize"));
		
		talentVO.setPageUnit(pageUnitInt);
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(talentVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(talentVO.getPageUnit());
		paginationInfo.setPageSize(talentVO.getPageSize());
		
		talentVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		talentVO.setLastIndex(paginationInfo.getLastRecordIndex());
		talentVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<TalentVO> resultList;
		try {
			resultList = talentService.retrievePagingList(talentVO);
			model.addAttribute("resultList", resultList);
			
			int totCnt = talentService.retrievePagingListCnt(talentVO);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "manage/talentManage";
	}
	
	@RequestMapping(path ="/createProcess.do", method = {RequestMethod.POST} )
	public String createProcess(TalentVO talentVO) {
		try {
			talentService.create(talentVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/talent/retrievePagingList.do";  // 등록 성공시 습관어 관리 페이지 리다이렉트
	}
	
	@RequestMapping("/massiveCreateProcess.do")
	public ModelAndView createMassiveTalent(MultipartHttpServletRequest request) {
		 MultipartFile excelFile = request.getFile("excelFile");
	        if(excelFile==null || excelFile.isEmpty()){
	            throw new RuntimeException("엑셀파일을 선택해 주세요");
	        }

	     File destFile = new File("D:\\"+excelFile.getOriginalFilename());
	     try {
	            excelFile.transferTo(destFile);
	            talentService.createMassiveTalent(destFile);
	        } catch (Exception e) {
	            throw new RuntimeException(e.getMessage(),e);
	 
	        }

	     destFile.delete();

	     ModelAndView view = new ModelAndView();
	        view.setViewName("redirect:/talent/retrievePagingList.do");
	        return view;
	}
	
	@RequestMapping(path ="/updateProcess.do", method = {RequestMethod.POST})
	public String updateProcess(TalentVO talentVO, Model model) {
		
		int updateCnt = 0;
		try {
			updateCnt = talentService.update(talentVO);
			if(updateCnt==1) {
				return "redirect:/talent/retrievePagingList.do"; // 업데이트 성공시 리다이렉트
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "manage/talentManage" ;
	}
	
	@RequestMapping(path ="/update.do")
	public String talentKeywordUpdate(TalentVO talentVO, Model model) {
		
		int updateCnt;
		try {
			updateCnt = talentService.update(talentVO);
			if(updateCnt==1) {
				return "redirect:/talent/keywordManage.do?talentSq="+talentVO.getTalentSq(); // 업데이트 성공시 리다이렉트
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "manage/talentKeywordManage";
	}
	
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model) {

		// 출력할 리스트 가져오기
		List<TalentVO> talentList;
		try {
			talentList = talentService.retrieveList();
			// excel 파일 header 설정 
			List<String> header = new ArrayList<String>();
			header.add("TALENT_SQ");
			header.add("TALENT_NM");
			header.add("TALENT_ST");
			
			// excel 파일 data 설정
			List<Map<String, String>> data = new ArrayList<Map<String, String>>();
			
			for(int i = 0; i<talentList.size(); i++) {
				Map<String, String> map = new HashMap<>();
				map.put("TALENT_SQ", talentList.get(i).getTalentSq());
				map.put("TALENT_NM", talentList.get(i).getTalentNm());
				map.put("TALENT_ST", talentList.get(i).getTalentSt());
				data.add(map);
			}
			
			model.addAttribute("header",header);
			model.addAttribute("data",data);
			model.addAttribute("fileName","TALENT");
			model.addAttribute("sheetName","TALENT");

		} catch (Exception e) {
			e.printStackTrace();
		}

		

		return "excelView";
	}
	
	@RequestMapping("/keywordManage.do")
	public String keywordManage(String talentSq, String pageUnit,String pageIndex, String searchKeyword, Model model) {
		
		// 인재상 가져오기
		TalentVO talentVO;
		try {
			talentVO = talentService.retrieve(talentSq);
			
		
		
			// 정렬 개수
			int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
			model.addAttribute("pageUnit" , pageUnitInt);
			
			// 현재 페이지 번호
			int pageIndexInt = pageIndex == null? 1 : Integer.parseInt(pageIndex);
			
		
			
			// 해당 인재상에 매칭된 키워드 목록 가져오기
			KeywordVO keywordVO = new KeywordVO();
			
			/** EgovPropertyService.sample */
			keywordVO.setPageUnit(propertiesService.getInt("pageUnit"));
			keywordVO.setPageSize(propertiesService.getInt("pageSize"));
			
			keywordVO.setPageUnit(pageUnitInt);
			keywordVO.setPageIndex(pageIndexInt);
			
			/** pageing setting */
			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(keywordVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(keywordVO.getPageUnit());
			paginationInfo.setPageSize(keywordVO.getPageSize());
			
			keywordVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			keywordVO.setLastIndex(paginationInfo.getLastRecordIndex());
			keywordVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			
			Map<String, Object> retrieveMap = new HashMap<>();
			retrieveMap.put("firstIndex", keywordVO.getFirstIndex());
			retrieveMap.put("lastIndex", keywordVO.getLastIndex());
			retrieveMap.put("talentSq", talentSq);
			retrieveMap.put("searchKeyword", searchKeyword);
			
			
			List<KeywordVO> resultList = null;
			
			
			resultList = keywordService.retrieveTalentKeywordPagingList(retrieveMap);
			model.addAttribute("resultList", resultList);
	
			int totCnt = keywordService.retrieveTalentKeywordPagingListCnt(retrieveMap);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("talentVO",talentVO);
			return "manage/talentKeywordManage";

		} catch (Exception e) { }
		return "manage/talentKeywordManage";
	}
	
	/* 인재상 통계 화면 */
	@RequestMapping("/statistics.do")
	public String statistics() {
		return "manage/talentStatistic";
	}
	
	@RequestMapping("/retrieveStatisticsPagingList.do")
	public String talentStatistics(TalentAnalysisVO talentAnalysisVO,String pageUnit, String startDate, String endDate, String searchKeyword, Model model) {
		
		Map<String, Object> statisticMap = new HashMap<>();
		statisticMap.put("startDate", startDate);
		statisticMap.put("endDate", endDate);
		statisticMap.put("searchKeyword", searchKeyword);
		
		
		int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
		model.addAttribute("pageUnit" , pageUnitInt);
		
		/** EgovPropertyService.sample */
		talentAnalysisVO.setPageUnit(propertiesService.getInt("pageUnit"));
		talentAnalysisVO.setPageSize(propertiesService.getInt("pageSize"));
		
		talentAnalysisVO.setPageUnit(pageUnitInt);
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(talentAnalysisVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(talentAnalysisVO.getPageUnit());
		paginationInfo.setPageSize(talentAnalysisVO.getPageSize());
		
		talentAnalysisVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		talentAnalysisVO.setLastIndex(paginationInfo.getLastRecordIndex());
		talentAnalysisVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		statisticMap.put("talentAnalysisVO", talentAnalysisVO);
		
		List<TalentAnalysisVO> talentCountList;
		try {
			talentCountList = talentService.retrieveStatisticsPagingList(statisticMap);
			model.addAttribute("talentCountList", talentCountList);
			
			int totCnt = talentService.retrieveStatisticsPagingListCnt(statisticMap);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return "jsonView";
	}
	

	
}
