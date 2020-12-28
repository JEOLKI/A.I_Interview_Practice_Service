package com.aiinterview.analysis.web;

import java.net.InetAddress;
import java.net.UnknownHostException;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aiinterview.analysis.service.HabitAnalysisService;
import com.aiinterview.analysis.service.ImageAnalysisService;
import com.aiinterview.analysis.service.KeywordAnalysisService;
import com.aiinterview.analysis.service.RepeatAnalysisService;
import com.aiinterview.analysis.service.VoiceAnalysisService;
import com.aiinterview.analysis.vo.HabitAnalysisVO;
import com.aiinterview.analysis.vo.ImageAnalysisVO;
import com.aiinterview.analysis.vo.RepeatAnalysisVO;
import com.aiinterview.analysis.vo.TalentAnalysisVO;
import com.aiinterview.analysis.vo.VoiceAnalysisVO;
import com.aiinterview.common.util.aes.AesCryptUtil;
import com.aiinterview.interview.service.AnswerService;
import com.aiinterview.interview.service.HabitService;
import com.aiinterview.interview.service.InterviewService;
import com.aiinterview.interview.service.QuestionService;
import com.aiinterview.interview.service.TalentService;
import com.aiinterview.interview.vo.AnswerVO;
import com.aiinterview.interview.vo.HabitVO;
import com.aiinterview.interview.vo.InterviewVO;
import com.aiinterview.interview.vo.QuestionVO;
import com.aiinterview.member.service.MemberService;
import com.aiinterview.member.vo.MemberVO;
import com.aiinterview.plan.service.PlanService;
import com.aiinterview.plan.vo.PlanStatisticsVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AnalysisController {
	
	@Resource(name = "memberService")
	private MemberService memberService;
	
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
	
    @Resource(name = "voiceAnalysisService")
    private VoiceAnalysisService voiceAnalysisService;
    
	@Resource(name = "planService")
	private PlanService planService;
	
	@Resource(name="talentService")
	private TalentService talentService;
    
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	@RequestMapping(value = "/analysis/interview/retrievePagingList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrievePagingList(InterviewVO interviewVO, HttpSession session, ModelMap model) {
		
		MemberVO memberVO = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = memberVO.getMemId();
		interviewVO.setMemId(memId);
		
		/** EgovPropertyService.sample */
		interviewVO.setPageUnit(propertiesService.getInt("interviewPageUnit"));
		interviewVO.setPageSize(propertiesService.getInt("interviewPageSize"));

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
		
		if(resultList.size()>0) {
			return "analysis/myInterview";
		}else {
			return "login/home";
		}
	}
	
	@RequestMapping(value = "/analysis/question/retrievePagingList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrievePagingList(QuestionVO questionVO, ModelMap model) {
		
		InetAddress server;
		
		try {
			server = InetAddress.getLocalHost();
			String serverIp = server.getHostAddress();
			model.addAttribute("serverIp", serverIp);
		} catch (UnknownHostException e2) {
			e2.printStackTrace();
		} 

		
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
		
		return "analysis/myInterviewResult";
	}
	
	@RequestMapping(value = "/answer/retrieve.do")
	public String retrieveView(String questSq, Model model, String shareMemId, String profilePath) {
		
		MemberVO memberVO = null;
		try {
			if(shareMemId != null) {
				memberVO = memberService.retrieve(shareMemId);
				model.addAttribute("profilePath", memberVO.getMemProfilePath());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("questSq", questSq);
		model.addAttribute("shareMemId", shareMemId);
		
		return "analysis/analysisResult";
	}
	
	@RequestMapping(value = "/analysis/answer/retrieveAnalysis.do")
	public String retrieveAnalysis(String questSq, Model model, HttpSession session,String shareMemId, String profilePath) {           
		model.addAttribute("shareMemId", shareMemId);
		model.addAttribute("profilePath", profilePath);
		String ansSq = "";
		
		try {
			AnswerVO answerVO = answerService.retrieve(questSq);
			ansSq = answerVO.getAnsSq(); 
			model.addAttribute("answerVO", answerVO);
			
			/* 이미지 분석 */
			ImageAnalysisVO imageAnalysis = imageAnalysisService.retrieveAnalysis(ansSq);
			List<ImageAnalysisVO> imageAnalysisList = imageAnalysisService.retrieveList(ansSq);
			model.addAttribute("imageAnalysis", imageAnalysis);
			model.addAttribute("imageAnalysisList", imageAnalysisList);
			
			/* 습관어  - habitAnalysisResultList*/
            List<HabitAnalysisVO> habitAnalysisList = habitAnalysisService.retrieveList(ansSq); // 데이터 리스트
			Map<String, String> habitAnalysisMap = new HashMap<String, String>();
			for(int i=0; i< habitAnalysisList.size(); i++) {
				String habitGb = habitService.retrieve(habitAnalysisList.get(i).getHabitSq());
				habitAnalysisMap.put(habitGb, habitAnalysisList.get(i).getHabitCount());
			}
			model.addAttribute("habitAnalysisMap",habitAnalysisMap);
			
			/* 반복어  - repeatAnalysisList*/
			List<RepeatAnalysisVO> repeatAnalysisList = repeatAnalysisService.retrieveList(ansSq);	// 데이터 리스트
			model.addAttribute("repeatAnalysisList", repeatAnalysisList);
			
			
			/* 인재상 - talentAnalysisList(인재상,퍼센트), keywordSet(키워드)*/
			List<TalentAnalysisVO> talentAnalysisList = keywordAnalysisService.retrieveTalentPercentList(ansSq);
			model.addAttribute("talentAnalysisList", talentAnalysisList); 
			
			// 인재상 개수만큼 각각 키워드 리스트 받아와
			Map<String, String> selectMap = new HashMap<>(); //키워드 목록 꺼내올 파라미터
			Map<String, List<String>> keywordResultMap = new HashMap<>();
			for(int i=0; i<talentAnalysisList.size();i++) {
				// 키워드 목록 가져오기
				selectMap.put("talentNm", talentAnalysisList.get(i).getTalentNm());
				selectMap.put("ansSq", ansSq);
				List<String> keywordList = keywordAnalysisService.retrieveKeywordList(selectMap);
				
				// 키워드 목록 키워드에 매칭해서 뷰로 보내기
				keywordResultMap.put(talentAnalysisList.get(i).getTalentNm(), keywordList);
			}
			model.addAttribute("keywordResultMap", keywordResultMap);
			
            /* 음성 - voiceAnalysisList (데시벨,헤르츠)*/
            List<VoiceAnalysisVO> voiceAnalysisList = voiceAnalysisService.retrieveList(ansSq);
            model.addAttribute("voiceAnalysisList", voiceAnalysisList);
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return "jsonView";
	}
	
	
	@RequestMapping(value="/analysis/image/retrieveGrowth.do")
	public String imageRetrieveGrowth(HttpSession session, Model model) {
		
		MemberVO memberVO = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = memberVO.getMemId();
		
		try {
			List<ImageAnalysisVO> imageAnalysisGrowth = imageAnalysisService.retrieveGrowth(memId);
			model.addAttribute("imageAnalysisGrowth", imageAnalysisGrowth);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
	}
	
	/* 성장그래프 - 말 빠르기 */
	@RequestMapping(value="/analysis/speed/retrieveGrowth.do")
	public String speedRetrieveGrowth(HttpSession session, Model model) {
		
		MemberVO memberVO = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = memberVO.getMemId();
		
		try {
			List<AnswerVO> answerSpeedGrowth = answerService.retrieveSpeedGrowth(memId);
			model.addAttribute("answerSpeedGrowth", answerSpeedGrowth);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
	}
	
	/* 성장그래프 - 습관어 (차트 )*/
	@RequestMapping(value="/analysis/habit/retrieveGrowth.do")
	public String habitRetrieveGrowth(HttpSession session, Model model) {
		
		MemberVO memberVO = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = memberVO.getMemId();
		
		try {
			List<HabitAnalysisVO> habitAnalysisGrowth = habitAnalysisService.retrieveGrowth(memId);
			model.addAttribute("habitAnalysisGrowth", habitAnalysisGrowth);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
	}
	
	/* 성장그래프 - 습관어별 (바) */
	@RequestMapping(value="/analysis/habit/retrieveCount.do")
	public String habitRetrieveCount(HttpSession session, Model model) {
		
		MemberVO memberVO = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = memberVO.getMemId();
		
		try {
			List<HabitVO> habitAnalysisCount = habitAnalysisService.retrieveCount(memId);
			model.addAttribute("habitAnalysisCount", habitAnalysisCount);
			List<HabitVO> habitList = habitService.retrieveUsingList();
			model.addAttribute("habitList", habitList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
	}
	
	/* 성장그래프- 음성분석 */
	@RequestMapping(value = "/analysis/voice/retrieveGrowth.do")
	public String voiceRetrieveGrowth(HttpSession session, Model model) {
		MemberVO memverVO = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = memverVO.getMemId();

		try {
			List<VoiceAnalysisVO> voiceAnalysisGrowth = voiceAnalysisService.retrieveGrowth(memId);
			model.addAttribute("voiceAnalysisGrowth", voiceAnalysisGrowth);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "jsonView";
	}
	
	public static String stringToHex(String s) {
        String result = "";

        for (int i = 0; i < s.length(); i++) {
          result += String.format("%02X", (int) s.charAt(i));
        }

        return result;
    } 
	
	@RequestMapping(value = "/analysis/share.do")
	public String share(String sharePw, String interviewSq, String shareMemId,  Model model) {
		
        String shareUrl = "/analysis/resultShare.do?interviewSq="+interviewSq+"&shareMemId="+shareMemId;
		
        model.addAttribute("aesSharePw", sharePw);
		model.addAttribute("shareMemId", shareMemId);
		model.addAttribute("shareUrl", shareUrl);
		
		return "analysis/analysisShare";
	}
	
	@RequestMapping(value = "/analysis/resultShare.do")
	public String resultShare(String aesSharePw, String inSharePw, String shareMemId, QuestionVO questionVO, Model model, RedirectAttributes rd) {
		
		String oriSharePw = AesCryptUtil.decrypt(aesSharePw);
		
		if(!inSharePw.equals(oriSharePw)) {
			rd.addAttribute("wrongMsg", "잘못된 코드입니다.");
			return "redirect:/analysis/share.do?sharePw="+aesSharePw+"&interviewSq="+questionVO.getInterviewSq()+"&shareMemId="+ shareMemId;
		}
		
		MemberVO shareMember = null;
		try {
			shareMember = memberService.retrieve(shareMemId);
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		
		model.addAttribute("shareMemId", shareMemId);
		model.addAttribute("profilePath", shareMember.getMemProfilePath());
		
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
		
		return "analysis/shareInterviewResult";
	}
	
	@RequestMapping(value="/analysis/manageStatistic.do")
	public String manageStatistic(Model model) {
		
		try {
			List<InterviewVO> interviewList = interviewService.retrieveStatistics();
			model.addAttribute("interviewList", interviewList);
			
			int interviewCount = 0;
			for (InterviewVO interviewVO : interviewList) {
				interviewCount += Integer.parseInt(interviewVO.getCount());
			}
			model.addAttribute("interviewCount", interviewCount);

			Map<String, String> statisticMap = new HashMap<>();

			/* 매출 통계 */
			List<PlanStatisticsVO> dailySaleList = planService.retrieveDailySale();
			model.addAttribute("dailySaleList", dailySaleList);
			
			int saleSum = 0;
			for(PlanStatisticsVO planStatisticsVO : dailySaleList) {
				saleSum += planStatisticsVO.getSale();
			}
			model.addAttribute("saleSum", saleSum);
			
			/* 요금제 통계 */
			List<PlanStatisticsVO> totalUseList = planService.retrieveTotalUse(statisticMap);
			model.addAttribute("totalUseList", totalUseList);
			
			/* 인재상 통계 */
			List<TalentAnalysisVO> talentCountList= talentService.retrieveStatisticsList(statisticMap);
			model.addAttribute("talentCountList", talentCountList);
			
			/* 습관어 */
			List<HabitAnalysisVO> habitUseList =  habitAnalysisService.retrieveHabitUseCountList(statisticMap);
			model.addAttribute("habitUseList", habitUseList);
			
			/* 반복어 */
			List<RepeatAnalysisVO> repeatUseList = repeatAnalysisService.retrieveStatistics();
			model.addAttribute("repeatUseList", repeatUseList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
	}
	
}
