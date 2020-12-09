package com.aiinterview.interview.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.aiinterview.interview.service.InterviewService;
import com.aiinterview.interview.service.QuestionService;
import com.aiinterview.interview.vo.InterviewVO;
import com.aiinterview.interview.vo.QuestionVO;

@RequestMapping("/interview")
@Controller
public class InterviewController {

	@Resource(name = "interviewService")
	private InterviewService interviewService;
	
	@Resource(name = "questionService")
	private QuestionService questionService;

	private static final Logger logger = LoggerFactory.getLogger(InterviewController.class);

	@RequestMapping(path = "/ready.do", method = { RequestMethod.GET })
	public String interviewReady() {
		logger.debug("InterviewController.interviewReady()진입");
		return "interview/ready";
	}

	@RequestMapping(path = "/setting.do", method = { RequestMethod.GET })
	public String interviewSetting(@RequestParam(name="questionList") List<String> questionList,
								   @RequestParam(name="sampQuestSqList") List<String> sampQuestSqList, Model model) {
		model.addAttribute("questionList", questionList);
		model.addAttribute("sampQuestSqList", sampQuestSqList);

		return "interview/setting";
	}

	@RequestMapping(path = "/start.do", method = { RequestMethod.GET })
	public String interviewStart(@RequestParam("questionList") List<String> questionList,
								 @RequestParam("sampQuestSqList") List<String> sampQuestSqList,
								 String memId, Model model) {
		
		InterviewVO interviewVO = new InterviewVO(memId); // 인터뷰 객체 생성
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("interviewVO", interviewVO); // map 객체에 면접 객체 넣기
		
		List<QuestionVO> questionVOList = new ArrayList<>();
		
		for(int i=0 ; i < questionList.size(); i++) { // 임의 질문 사이즈만큼
			QuestionVO questionVO = new QuestionVO(questionList.get(i), sampQuestSqList.get(i));
			questionVOList.add(questionVO); // 최종 질문 목록에 추가
		}
		
		map.put("questionVOList", questionVOList);
		
		String interviewSq = "";
		try {
			interviewSq = interviewService.create(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			List<QuestionVO> questionGoList = questionService.retrieveList(interviewSq);
			model.addAttribute("questionGoList", questionGoList);
			logger.debug("questionGoList 내용 {} ", questionGoList.get(0).getQuestContent());
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return "interview/start";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(path = "/blobtest.do", method = RequestMethod.GET)
    public String blobTest(Model model) {
       
       return "interview/bloTest";
    }
	
	@RequestMapping(path = "/blobtester.do", method = RequestMethod.POST)
	@ResponseBody
	public String blobTestR(Model model, MultipartHttpServletRequest data, String name) {

		Iterator<String> iter = data.getFileNames();
		MultipartFile mfile = null;
		String fieldName = "";
		while (iter.hasNext()) {
			fieldName = (String) iter.next(); // 파일이름, 위에서 file1과 file2로 보냈으니 file1, file2로 나온다.
			mfile = data.getFile(fieldName); // 저장된 파일 객체
			System.out.println("결과 1 : " + fieldName); // 데이터 이름
			System.out.println("결과 2 : " + mfile); // 주소값
			System.out.println("결과 3 : " + mfile.getName());
			System.out.println("결과 4 : " + mfile.getOriginalFilename());
			try {
				System.out.println("결과 5 : " + mfile.getBytes());
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			System.out.println("결과 6 : " + mfile.getSize());

			model.addAttribute("result1", mfile);

			try {
				mfile.transferTo(new File("D:\\test")); // 확장자 붙여야함
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println("데이터 결과: " + data);
		model.addAttribute("result2", data);
		return "jsonView";
	}

}
