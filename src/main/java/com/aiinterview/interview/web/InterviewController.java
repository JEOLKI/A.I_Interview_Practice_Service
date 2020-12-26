package com.aiinterview.interview.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aiinterview.interview.service.InterviewService;
import com.aiinterview.interview.service.QuestionService;
import com.aiinterview.interview.vo.InterviewVO;
import com.aiinterview.interview.vo.QuestionVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/interview")
@Controller
public class InterviewController {

	@Resource(name = "interviewService")
	private InterviewService interviewService;
	
	@Resource(name = "questionService")
	private QuestionService questionService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

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
	@RequestMapping(path="/redirectStart.do",method = { RequestMethod.GET })
	public String redirectStart(Model model, String interviewSq){
		try {
			List<QuestionVO> questionGoList = questionService.retrieveList(interviewSq);
			model.addAttribute("questionGoList", questionGoList);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		model.addAttribute("interviewSq",interviewSq);
		return "interview/start";
	}

	@RequestMapping(path = "/start.do", method = { RequestMethod.GET })
	public String interviewStart(@RequestParam("questionList") List<String> questionList,
								 @RequestParam("sampQuestSqList") List<String> sampQuestSqList,
								 String memId, Model model) {
		
		List<String> editQuestionList = new ArrayList<>(); // 치환시킨 문장을 담을 객체
		
		for(int i =0; i<questionList.size(); i++) {
			String edit = questionList.get(i).replace(".",",");
			editQuestionList.add(edit);
		}
		for(int i =0; i<editQuestionList.size(); i++) {
			logger.debug("확인{}",editQuestionList.get(i));
		}
		
		InterviewVO interviewVO = new InterviewVO(memId); // 인터뷰 객체 생성
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("interviewVO", interviewVO); // map 객체에 면접 객체 넣기
		
		List<QuestionVO> questionVOList = new ArrayList<>();
		
		for(int i=0 ; i < editQuestionList.size(); i++) { // 임의 질문 사이즈만큼
			QuestionVO questionVO = new QuestionVO(editQuestionList.get(i), sampQuestSqList.get(i));
			questionVOList.add(questionVO); // 최종 질문 목록에 추가
		}
		
		map.put("questionVOList", questionVOList);
		
		String interviewSq = "";
		try {
			interviewSq = interviewService.create(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/interview/redirectStart.do?interviewSq="+interviewSq;
	}
	
	
	@RequestMapping(path="/update.do", method = { RequestMethod.POST })
	public String update(InterviewVO interviewVO, Model model) {
		
		try {
			int result = interviewService.update(interviewVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/analysis/question/retrievePagingList.do?interviewSq=" + interviewVO.getInterviewSq();
	}
	
	
	@RequestMapping(value = "/retrievePagingList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrievePagingList(InterviewVO interviewVO, HttpSession session, Model model) {
		

		/** EgovPropertyService.sample */
		interviewVO.setPageUnit(propertiesService.getInt("pageUnit"));
		interviewVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(interviewVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(interviewVO.getPageUnit());
		paginationInfo.setPageSize(interviewVO.getPageSize());

		interviewVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		interviewVO.setLastIndex(paginationInfo.getLastRecordIndex());
		interviewVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<InterviewVO> resultList = new ArrayList<>();
		try {
			resultList = interviewService.retrievePagingList(interviewVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("resultList", resultList);

		int totCnt = 0;
		try {
			totCnt = interviewService.retrievePagingListCnt(interviewVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		try {
			List<InterviewVO> interviewList = interviewService.retrieveList();
			model.addAttribute("interviewList", interviewList);
		} catch (Exception e) {
		}
		
		return "manage/interviewManage";
	}
	
	
	@RequestMapping(value="/statistic.do")
	public String statistic(Model model) {
		
		return "manage/interviewStatistics";
	}
	
	@RequestMapping(value="/retrieveStatistics.do")
	public String retrieveStatistics(Model model) {
		
		try {
			List<InterviewVO> interviewList = interviewService.retrieveStatistics();
			model.addAttribute("interviewList", interviewList);
		} catch (Exception e) {
			
		}
		
		return "jsonView";
	}
	
	/* 일괄 다운로드 */
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model)  {
		
		// 출력할 리스트 가져오기
		List<InterviewVO> interviewList = new ArrayList<>();
		try {
			interviewList = interviewService.retrieveList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//Model 객체에 header, data
		List<String> header = new ArrayList<String>();
		header.add("INTERVIEW_SQ");
		header.add("INTERVIEW_NM");
		header.add("INTERVIEW_DATE");
		header.add("INTERVIEW_MEMID");
	
		// excel 파일 data 설정
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();

		for(int i = 0; i< interviewList.size(); i++) {
			Map<String, String> map = new HashMap<>();
			map.put("INTERVIEW_SQ", interviewList.get(i).getInterviewSq());
			map.put("INTERVIEW_NM", interviewList.get(i).getInterviewNm());
			map.put("INTERVIEW_DATE", interviewList.get(i).getInterviewNm());
			map.put("INTERVIEW_MEMID", interviewList.get(i).getMemId());
			data.add(map);
		}
		
		model.addAttribute("header",header);
		model.addAttribute("data",data);
		model.addAttribute("fileName","INTERVIEWLIST");
		model.addAttribute("sheetName","면접 통계");
		model.addAttribute("titleSize", header.size());
		
		return "excelView";
	}
	
	@RequestMapping(value="/end.do", method = {RequestMethod.GET})
	public String end(String interviewSq, RedirectAttributes ra) {
		ra.addAttribute("interviewSq",interviewSq);
		return"redirect:/analysis/question/retrievePagingList.do";
	}
	
	

}
