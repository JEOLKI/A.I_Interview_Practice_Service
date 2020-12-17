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

import com.aiinterview.interview.service.QuestionGubunService;
import com.aiinterview.interview.vo.QuestionGubunVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/questGb")
@Controller
public class QuestionGubunController {

	@Resource(name = "questionGubunService")
	private QuestionGubunService questionGubunService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	

	
	/* 페이징 처리 */
	@RequestMapping(value = "/retrievePagingList.do")
	public String retrievePagingList(QuestionGubunVO questGbVO, String pageUnit, Model model){
		
		int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
		model.addAttribute("pageUnit" , pageUnitInt);
		
		/** EgovPropertyService.sample */
		questGbVO.setPageUnit(propertiesService.getInt("pageUnit"));
		questGbVO.setPageSize(propertiesService.getInt("pageSize"));
		
		questGbVO.setPageUnit(pageUnitInt);
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(questGbVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(questGbVO.getPageUnit());
		paginationInfo.setPageSize(questGbVO.getPageSize());
		

		
		questGbVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		questGbVO.setLastIndex(paginationInfo.getLastRecordIndex());
		questGbVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<QuestionGubunVO> resultList = questionGubunService.retrievePagingList(questGbVO);
		model.addAttribute("resultList", resultList);

		int totCnt = questionGubunService.retrievePagingListCnt(questGbVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "manage/questionGubunManage";
	}

	
	/* 등록 */
	@RequestMapping("/createProcess.do")
	public String createQuestGbProcess(QuestionGubunVO questGbVO) {
		
		try {
			questionGubunService.create(questGbVO);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/questGb/retrievePagingList.do";
	}
	
	@RequestMapping("/searchlist.do")
	public String retrieveQuestGbSearch(String keyword, Model model){
		System.out.println("질문 구분 검색 keyword : " + keyword);

		List<QuestionGubunVO> questGbSearchList = null;
		try {
			questGbSearchList = questionGubunService.retrieveQuestGbSearchList(keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("질문 구분 검색 목록 " + questGbSearchList);
		model.addAttribute("questGbSearchList", questGbSearchList);
		
		return "jsonView";
	}

	@RequestMapping("/massiveCreateProcess.do")
	public String createMassiveHabit(MultipartHttpServletRequest request){
		MultipartFile excelFile = request.getFile("excelFile");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택해 주세요");
		}

		File destFile = new File("D:\\" + excelFile.getOriginalFilename());
		try {
			excelFile.transferTo(destFile);
			questionGubunService.createMassiveQuestGb(destFile);
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage(), e);

		}

		destFile.delete();

		return "redirect:/questGb/retrievePagingList.do";

	}

	@RequestMapping(path = "/updateProcess.do", method = { RequestMethod.POST })
	public String updateProcess(QuestionGubunVO questGbVO, Model model) {
		System.out.println("질문 구분 수정 - questGbVO : " + questGbVO);

		int updateCnt = questionGubunService.update(questGbVO);
		System.out.println("질문 구분 수정 - updateCnt : " + updateCnt);
		if (updateCnt == 1) {
			return "redirect:/questGb/retrievePagingList.do"; // 업데이트 성공시 리다이렉트
		} else {
			return "manage/questionGubunManage";
		}
	}

	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model) {

		// 출력할 리스트 가져오기
		List<QuestionGubunVO> questGbList;
		try {
			questGbList = questionGubunService.retrieveList();
			//Model 객체에 header, data
			List<String> header = new ArrayList<String>();
			header.add("QUEST_GB_SQ");
			header.add("QUEST_GB_CONTENT");
			header.add("QUEST_GB_ST");
			
			// excel 파일 data 설정
			List<Map<String, String>> data = new ArrayList<Map<String, String>>();
			
			for(int i = 0; i<questGbList.size(); i++) {
				Map<String, String> map = new HashMap<>();
				map.put("QUEST_GB_SQ", questGbList.get(i).getQuestGbSq());
				map.put("QUEST_GB_CONTENT", questGbList.get(i).getQuestGbContent());
				map.put("QUEST_GB_ST", questGbList.get(i).getQuestGbSt());
				data.add(map);
			}
			
			model.addAttribute("header",header);
			model.addAttribute("data",data);
			model.addAttribute("fileName","QUESTION_GB");
			model.addAttribute("sheetName","QUESTION_GB");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		
		return "excelView";
	}

}
