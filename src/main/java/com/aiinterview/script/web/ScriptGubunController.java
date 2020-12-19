package com.aiinterview.script.web;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.aiinterview.analysis.vo.ScriptAnalysisVO;
import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.service.ScriptService;
import com.aiinterview.script.vo.ScriptGubunVO;
import com.aiinterview.script.vo.ScriptTestVO;
import com.aiinterview.script.vo.ScriptVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/scriptGubun")
@Controller
public class ScriptGubunController {
	private static final Logger logger = LoggerFactory.getLogger(ScriptGubunController.class);
	
	@Resource(name="scriptGubunService")
	private ScriptGubunService scriptGubunService;
	
	@Resource(name="scriptService")
	private ScriptService scriptService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	
	/* 페이징 리스트 별 스크립트 구분*/
	@RequestMapping("/retrievePagingList.do")
	public String retrievePagingList(@ModelAttribute("scriptGubunVO") ScriptGubunVO scriptGubunbVO, String pageUnit, Model model) {
		
		int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
		model.addAttribute("pageUnit" , pageUnitInt);
		
		/** EgovPropertyService.sample */
		scriptGubunbVO.setPageUnit(propertiesService.getInt("pageUnit"));
		scriptGubunbVO.setPageSize(propertiesService.getInt("pageSize"));
		
		scriptGubunbVO.setPageUnit(pageUnitInt);
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(scriptGubunbVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(scriptGubunbVO.getPageUnit());
		paginationInfo.setPageSize(scriptGubunbVO.getPageSize());
		
		scriptGubunbVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		scriptGubunbVO.setLastIndex(paginationInfo.getLastRecordIndex());
		scriptGubunbVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<ScriptGubunVO> resultList;
		try {
			resultList = scriptGubunService.retrievePagingList(scriptGubunbVO);
			model.addAttribute("scriptGbList", resultList);
			
			logger.debug("resultList : {}", resultList);
			
			int totCnt =scriptGubunService.retrievePagingListCnt(scriptGubunbVO);
			paginationInfo.setTotalRecordCount(totCnt);
			
			model.addAttribute("paginationInfo", paginationInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "manage/scriptGubunManage";
	}
	

	@RequestMapping("/scriptManage.do")
	public String scriptManage(ScriptVO scriptVO, String scriptGbSq, String pageUnit, String pageIndex, String searchKeyword, Model model) {
		
		ScriptGubunVO scriptGbVO = null;
		try {
			scriptGbVO = scriptGubunService.retrieve(scriptGbSq);
		
			model.addAttribute("scriptGbVO", scriptGbVO);
			model.addAttribute("scriptGbSq", scriptGbSq);
			
			// 정렬 개수
			int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
			model.addAttribute("pageUnit" , pageUnitInt);
			
			// 현재 페이지 번호
			int pageIndexInt = pageIndex == null? 1 : Integer.parseInt(pageIndex);
			
			/** EgovPropertyService.sample */
			scriptVO.setPageUnit(propertiesService.getInt("pageUnit"));
			scriptVO.setPageSize(propertiesService.getInt("pageSize"));
			
			scriptVO.setPageUnit(pageUnitInt);
			scriptVO.setPageIndex(pageIndexInt);
			
			/** pageing setting */
			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(scriptVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(scriptVO.getPageUnit());
			paginationInfo.setPageSize(scriptVO.getPageSize());
			
			scriptVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			scriptVO.setLastIndex(paginationInfo.getLastRecordIndex());
			scriptVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			
			Map<String, Object> retrieveMap = new HashMap<>();
			retrieveMap.put("firstIndex", scriptVO.getFirstIndex());
			retrieveMap.put("lastIndex", scriptVO.getLastIndex());
			retrieveMap.put("scriptGbSq", scriptGbSq);
			retrieveMap.put("searchKeyword", searchKeyword);
			
			
			List<ScriptVO> resultList = null;
			
			//활성 상태가 "Y"인 스크립트 구분만 리스트에 추가하여 scriptManage페이지로 전송
			List<ScriptGubunVO> scriptGbList = null;
		

			scriptGbList = scriptGubunService.retrieveList();
			List<ScriptGubunVO> availableGbList = new ArrayList<>();
			for (ScriptGubunVO scriptGb : scriptGbList) {
				if (scriptGb.getScriptGbSt().equals("Y")) {
					availableGbList.add(scriptGb);
				}
			}
			model.addAttribute("scriptGbList", availableGbList);

			
			resultList = scriptService.retrieveScriptGbScriptPagingList(retrieveMap);
			model.addAttribute("resultList", resultList);

			logger.debug("scriptList : {}", resultList);
			
			int totCnt = scriptService.retrieveScriptGbScriptPagingListCnt(scriptVO);
			
			logger.debug("totCnt : {}", totCnt);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
			return "manage/scriptManage";
		} catch (Exception e) { }
		return "manage/scriptManage";
	}
	
	/* 단일 등록 */
	@RequestMapping(path="/createProcess.do", method = {RequestMethod.POST})
	public String createProcess(String scriptGbContent, String scriptGbSt) {
		ScriptGubunVO scriptGbVO = new ScriptGubunVO(scriptGbContent, scriptGbSt);
		try {
			scriptGubunService.create(scriptGbVO);
		} catch (Exception e) {
		}
		logger.debug("scriptGbVO : {}", scriptGbVO);
		
		return "redirect:/scriptGubun/retrievePagingList.do";
	}
	
	/* 일괄 등록 */
	@RequestMapping("/massiveCreateProcess.do")
	public String createMassiveScriptGb(MultipartHttpServletRequest request) {
		 MultipartFile excelFile = request.getFile("excelFile");
		 logger.debug("excelFile : {}", excelFile);
	        if(excelFile==null || excelFile.isEmpty()){
	            throw new RuntimeException("엑셀파일을 선택해 주세요");
	        }

	     File destFile = new File("D:\\"+excelFile.getOriginalFilename());
	     try {
	            excelFile.transferTo(destFile);
	            scriptGubunService.createMassiveScriptGubun(destFile);
	        } catch (Exception e) {
	        }

	     destFile.delete();

	     return "redirect:/scriptGubun/retrievePagingList.do";
	}
	
	/* 수정 */
	@RequestMapping(path="/updateProcess.do", method = {RequestMethod.POST})
	public String updateProcess(@ModelAttribute("scriptGubunVO") ScriptGubunVO scriptGbVO){
		
		try {

		int updateCnt = 0;
			for(int i=0; i<scriptGbVO.getScriptGbSqs().length; i++) {
				ScriptGubunVO updateScriptGbVO = scriptGubunService.retrieve(scriptGbVO.getScriptGbSqs()[i]);
				updateScriptGbVO.setScriptGbContent(scriptGbVO.getScriptGbContents()[i]);
				updateScriptGbVO.setScriptGbSt(scriptGbVO.getScriptGbSts()[i]);
				updateCnt += scriptGubunService.update(updateScriptGbVO);
			}
			
			if(updateCnt == scriptGbVO.getScriptGbSqs().length) {
				return "redirect:/scriptGubun/retrievePagingList.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "manage/scriptGubunManage";
	}
	
	/* 일괄 다운로드 */
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model) {
	
		//출력할 스크립트 구분 전체 리스트
		List<ScriptGubunVO> scriptGbList = null;
		try {
			scriptGbList = scriptGubunService.retrieveList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//excel 파일의 header
		List<String> header = new ArrayList<String>();
		header.add("SCRIPT_GB_SQ");
		header.add("SCRIPT_GB_CONTENT");
		header.add("SCRIPT_GB_ST");

		//excel 파일의 data
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();
		
		Map<String, String> map = null;
		for(ScriptGubunVO scriptGb : scriptGbList) {
			map = new HashMap<String, String>();
			map.put("SCRIPT_GB_SQ", scriptGb.getScriptGbSq());
			map.put("SCRIPT_GB_CONTENT", scriptGb.getScriptGbContent());
			map.put("SCRIPT_GB_ST", scriptGb.getScriptGbSt());
			data.add(map);
		}
		
		model.addAttribute("header", header);
		model.addAttribute("data", data);
		model.addAttribute("fileName", "SCRIPT_GUBUN");
		model.addAttribute("sheetName", "SCRIPT_GUBUN");
	
		return "excelView";
	}


	/* 통계 화면*/
	@RequestMapping(path = "/statistics.do", method = { RequestMethod.GET })
	public String statisticsView(Model model) throws Exception {
		
		//활성 상태가 "Y"인 스크립트 구분만 리스트에 추가하여 scriptManage페이지로 전송
		List<ScriptGubunVO> scriptGbList = null;
	

		scriptGbList = scriptGubunService.retrieveList();
		List<ScriptGubunVO> availableGbList = new ArrayList<>();
		for (ScriptGubunVO scriptGb : scriptGbList) {
			if (scriptGb.getScriptGbSt().equals("Y")) {
				availableGbList.add(scriptGb);
			}
		}
		model.addAttribute("scriptGbList", availableGbList);
		
		return "script/scriptGbStatistics";
	}
	
	/* 통계 : 스구별 스테에 사용된 스 사용 빈도*/
	@RequestMapping("/retrieveRankingList.do")
	public String retrieveRankingList(String scriptGbSq, String startDate, String endDate, Model model) {
		
		Map<String, String> statisticMap = new HashMap<>();
		statisticMap.put("startDate", startDate);
		statisticMap.put("endDate", endDate);
		statisticMap.put("scriptGbSq", scriptGbSq);
		
		
		List<ScriptAnalysisVO> scriptRankingList;
		try {
			//여기에 머잇냐면  랭킹, 스시, 스크립트문, totCnt
			scriptRankingList = scriptGubunService.retrieveRankingList(statisticMap);
			
			logger.debug("scripbRankingList : {}", scriptRankingList);
			model.addAttribute("scriptRankingList", scriptRankingList);
		} catch (Exception e) {
		}
		
		return "jsonView";
	}
	
	/* 통계 : 스구별 점수 표준편차 */
	@RequestMapping("/retrieveScoreList.do")
	public String retrieveScoreList(String scriptGbSq, Model model) {
		
		List<ScriptTestVO> scriptScoreList = null;
		try {
			scriptScoreList = scriptGubunService.retrieveScoreList(scriptGbSq);
		} catch (Exception e) {
		}
		logger.debug("scriptScoreList : {}", scriptScoreList);
		model.addAttribute("scriptScoreList", scriptScoreList);
		
		return "jsonView";
		
	}
	
}