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

@RequestMapping("/questGb")
@Controller
public class QuestionGubunController {

	@Resource(name = "questionGubunService")
	private QuestionGubunService questionGubunService;

	@RequestMapping("/manage.do")
	public String manage() {
		return "question/questionGubunManage";
	}

	@RequestMapping("/list.do")
	public String retrieveQuestGbList(Model model) throws Exception {

		List<QuestionGubunVO> questGbList = questionGubunService.retrieveQuestGbList();
		System.out.println("질문 구분 목록 " + questGbList);
		model.addAttribute("questGbList", questGbList);

		return "jsonView";
	}

	@RequestMapping("/createProcess.do")
	public String createQuestGbProcess(QuestionGubunVO questGbVO) throws Exception {

		System.out.println("질문 구분 등록 - questGbVO : " + questGbVO);

		questionGubunService.create(questGbVO);

		System.out.println("질문 구분 등록 후");

		return "redirect:/questGb/manage.do";
	}
	
	@RequestMapping("/searchlist.do")
	public String retrieveQuestGbSearch(String keyword, Model model) throws Exception {
		System.out.println("질문 구분 검색 keyword : " + keyword);

		List<QuestionGubunVO> questGbSearchList = questionGubunService.retrieveQuestGbSearchList(keyword);
		System.out.println("질문 구분 검색 목록 " + questGbSearchList);
		model.addAttribute("questGbSearchList", questGbSearchList);
		
		return "jsonView";
	}

	@RequestMapping("/massiveCreateProcess.do")
	public String createMassiveHabit(MultipartHttpServletRequest request) throws Exception {
		MultipartFile excelFile = request.getFile("excelFile");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택해 주세요");
		}

		File destFile = new File("D:\\" + excelFile.getOriginalFilename());
		try {
			excelFile.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			throw new RuntimeException(e.getMessage(), e);

		}

		questionGubunService.createMassiveQuestGb(destFile);

		destFile.delete();

		return "redirect:/questGb/manage.do";

	}

	@RequestMapping(path = "/updateProcess.do", method = { RequestMethod.POST })
	public String updateProcess(QuestionGubunVO questGbVO, Model model) {
		System.out.println("질문 구분 수정 - questGbVO : " + questGbVO);

		int updateCnt = questionGubunService.update(questGbVO);
		System.out.println("질문 구분 수정 - updateCnt : " + updateCnt);
		if (updateCnt == 1) {
			return "redirect:/questGb/manage.do"; // 업데이트 성공시 리다이렉트
		} else {
			return "question/questionGubunManage";
		}
	}

	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model) throws Exception {

		// 출력할 리스트 가져오기
		List<QuestionGubunVO> questGbList = questionGubunService.retrieveQuestGbList();

		
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
		
		return "excelView";
	}

}
