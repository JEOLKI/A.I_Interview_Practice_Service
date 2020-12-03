package com.aiinterview.interview.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.aiinterview.interview.service.TalentService;
import com.aiinterview.interview.vo.TalentVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/talent")
@Controller
public class TalentController {

	@Resource(name="talentService")
	private TalentService talentService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/* 페이징 처리 */
	@RequestMapping("/retrievePagingList.do")
	public String retrievePagingList(TalentVO talentVO, Model model) {
		
		/** EgovPropertyService.sample */
		talentVO.setPageUnit(propertiesService.getInt("pageUnit"));
		talentVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(talentVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(talentVO.getPageUnit());
		paginationInfo.setPageSize(talentVO.getPageSize());
		
		talentVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		talentVO.setLastIndex(paginationInfo.getLastRecordIndex());
		talentVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<TalentVO> resultList = talentService.retrievePagingList(talentVO);
		model.addAttribute("resultList", resultList);
		
		int totCnt = talentService.retrievePagingListCnt(talentVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		return "talent/talentManage";
	}
	
	@RequestMapping(path ="/createProcess.do", method = {RequestMethod.POST} )
	public String createProcess(TalentVO talentVO) throws Exception {
		
		
		talentService.create(talentVO);
		
		return "redirect:/talent/retrievePagingList.do";  // 등록 성공시 습관어 관리 페이지 리다이렉트
	}
	
	@RequestMapping("/massiveCreateProcess.do")
	public ModelAndView createMassiveTalent(MultipartHttpServletRequest request) throws Exception {
		 MultipartFile excelFile = request.getFile("excelFile");
	        if(excelFile==null || excelFile.isEmpty()){
	            throw new RuntimeException("엑셀파일을 선택해 주세요");
	        }

	     File destFile = new File("D:\\"+excelFile.getOriginalFilename());
	     try {
	            excelFile.transferTo(destFile);
	        } catch (IllegalStateException | IOException e) {
	            throw new RuntimeException(e.getMessage(),e);
	 
	        }

	     talentService.createMassiveTalent(destFile);
	     
	     destFile.delete();

	     ModelAndView view = new ModelAndView();
	        view.setViewName("redirect:/talent/retrievePagingList.do");
	        return view;
	}
	
	@RequestMapping(path ="/updateProcess.do", method = {RequestMethod.POST})
	public String updateProcess(TalentVO talentVO, Model model) {
		
		int updateCnt = talentService.update(talentVO);
		if(updateCnt==1) {
			return "redirect:/talent/retrievePagingList.do"; // 업데이트 성공시 리다이렉트
		}else {
			return "talent/talentManage";
		}
	}
	
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model) throws Exception {

		// 출력할 리스트 가져오기
		List<TalentVO> talentList = talentService.retrieveList();

		
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

		return "excelView";
	}

	
}
