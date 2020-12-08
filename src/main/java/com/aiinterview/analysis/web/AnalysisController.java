package com.aiinterview.analysis.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.analysis.service.HabitAnalysisService;
import com.aiinterview.analysis.service.ImageAnalysisService;
import com.aiinterview.analysis.service.KeywordAnalysisService;
import com.aiinterview.analysis.service.RepeatAnalysisService;
import com.aiinterview.analysis.vo.HabitAnalysisVO;
import com.aiinterview.analysis.vo.ImageAnalysisVO;
import com.aiinterview.analysis.vo.KeywordAnalysisVO;
import com.aiinterview.analysis.vo.RepeatAnalysisVO;
import com.aiinterview.analysis.vo.TalentAnalysisVO;
import com.aiinterview.interview.service.AnswerService;
import com.aiinterview.interview.service.HabitService;
import com.aiinterview.interview.service.InterviewService;
import com.aiinterview.interview.service.KeywordService;
import com.aiinterview.interview.service.QuestionService;
import com.aiinterview.interview.service.TalentService;
import com.aiinterview.interview.vo.AnswerVO;
import com.aiinterview.interview.vo.InterviewVO;
import com.aiinterview.interview.vo.QuestionVO;
import com.aiinterview.interview.vo.TalentVO;
import com.aiinterview.member.vo.MemberVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/analysis")
@Controller
public class AnalysisController {
	
	@Resource(name = "interviewService")
	private InterviewService interviewService;
	
	@Resource(name = "questionService")
	private QuestionService questionService;
	
	@Resource(name = "answerService")
	private AnswerService answerService;
	
	@Resource(name = "imageAnalysisService")
	private ImageAnalysisService imageAnalysisService;
	
	@Resource(name = "repeatAnalysisService")
	private RepeatAnalysisService repeatAnalysisService;
	
	@Resource(name = "keywordAnalysisService")
	private KeywordAnalysisService keywordAnalysisService;
	
	@Resource(name = "habitAnalysisService")
	private HabitAnalysisService habitAnalysisService; 
	
	@Resource(name = "habitService")
	private HabitService habitService;
	
	@Resource(name = "keywordService")
	private KeywordService keywordService;
	
	@Resource(name = "talentService")
	private TalentService talentService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	//http://localhost/analysis/interview/retrievePagingList.do
	@RequestMapping(value = "/interview/retrievePagingList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrievePagingList(InterviewVO interviewVO, HttpSession session, ModelMap model) {
		
		MemberVO memberVO = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = memberVO.getMemId();
		interviewVO.setMemId(memId);
		
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

		return "analysis/myinterview";
	}
	
	@RequestMapping(value = "/question/retrievePagingList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrievePagingList(QuestionVO questionVO, ModelMap model) {
		
		try {
			InterviewVO interviewVO = interviewService.retrieve(questionVO.getInterviewSq());
			model.addAttribute("interviewVO", interviewVO);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		/** EgovPropertyService.sample */
		questionVO.setPageUnit(propertiesService.getInt("pageUnit"));
		questionVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(questionVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(questionVO.getPageUnit());
		paginationInfo.setPageSize(questionVO.getPageSize());
		
		questionVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		questionVO.setLastIndex(paginationInfo.getLastRecordIndex());
		questionVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<QuestionVO> resultList = new ArrayList<>();
		try {
			resultList = questionService.retrievePagingList(questionVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("resultList", resultList);
		
		int totCnt = 0;
		try {
			totCnt = questionService.retrievePagingListCnt(questionVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "analysis/myinterviewresult";
	}
	
	@RequestMapping(value = "/answer/retrieve.do")
	public String retrieve(String questSq, Model model) {
		
//		String ansSq = "";
		String ansSq = questSq;
		
		try {
//			AnswerVO answerVO = answerService.retrieve(questSq);
//			ansSq = answerVO.getAnsSq();
//			model.addAttribute("answerVO", answerVO);
			
//			List<ImageAnalysisVO> imageAnalysisList = imageAnalysisService.retrieveList(ansSq);
//			model.addAttribute("imageAnalysisList", imageAnalysisList);
			
			/* 습관어  - habitAnalysisResultList*/
			List<HabitAnalysisVO> habitAnalysisList = habitAnalysisService.retrieveList(ansSq); // 데이터 리스트
			List<Map<String, String>> habitAnalysisResultList = new ArrayList<>();				// 리포드용 결과 리스트
			for(int i=0; i< habitAnalysisList.size(); i++) {
				Map<String, String> habitAnalysisMap = new HashMap<String, String>();
				String habitGb = habitService.retrieve(habitAnalysisList.get(i).getHabitSq());
				habitAnalysisMap.put(habitGb, habitAnalysisList.get(i).getHabitCount());
				habitAnalysisResultList.add(habitAnalysisMap);
			}
			model.addAttribute("habitAnalysisResultList", habitAnalysisResultList);
			
			
			/* 반복어  - repeatAnalysisList*/
			List<RepeatAnalysisVO> repeatAnalysisList = repeatAnalysisService.retrieveList(ansSq);	// 데이터 리스트
			model.addAttribute("repeatAnalysisList", repeatAnalysisList);
			
			
			/* 인재상 - talentAnalysisResultList, talentKeywordList, talentSum */
//			List<TalentAnalysisVO> talentAnalysisList = keywordAnalysisService.talentAnalysisList(talentSq);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
	}
	
}
