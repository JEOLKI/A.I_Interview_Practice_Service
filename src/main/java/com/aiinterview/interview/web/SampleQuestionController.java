package com.aiinterview.interview.web;

import java.io.File;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.javassist.expr.NewArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.aiinterview.interview.service.QuestionGubunService;
import com.aiinterview.interview.service.SampleQuestionService;
import com.aiinterview.interview.vo.QuestionGubunVO;
import com.aiinterview.interview.vo.SampleQuestionVO;
import com.aiinterview.plan.vo.PlanStatisticsVO;
import com.aiinterview.script.vo.ScriptVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/sampQuest")
@Controller
public class SampleQuestionController {
	
	private static final Logger logger = LoggerFactory.getLogger(SampleQuestionController.class);

	@Resource(name="sampleQuestionService")
	private SampleQuestionService sampleQuestionService;
	
	@Resource(name = "questionGubunService")
	private QuestionGubunService questionGubunService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	@RequestMapping("/retrievePagingList.do")
	public String retrievePagingList( QuestionGubunVO questGbVO, SampleQuestionVO sampQuestVO, String pageUnit, Model model){
	
		int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
		model.addAttribute("pageUnit" , pageUnitInt);
		
		/** EgovPropertyService.sample */
		sampQuestVO.setPageUnit(propertiesService.getInt("pageUnit"));
		sampQuestVO.setPageSize(propertiesService.getInt("pageSize"));
		
		sampQuestVO.setPageUnit(pageUnitInt);
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(sampQuestVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(sampQuestVO.getPageUnit());
		paginationInfo.setPageSize(sampQuestVO.getPageSize());
		
		
		sampQuestVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		sampQuestVO.setLastIndex(paginationInfo.getLastRecordIndex());
		sampQuestVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<SampleQuestionVO> resultList;
		try {
			resultList = sampleQuestionService.retrievePagingList(sampQuestVO);
			model.addAttribute("resultList", resultList);
			
			int totCnt = sampleQuestionService.retrievePagingListCnt(sampQuestVO);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		/* 질문 구분 목록 추출 */
		List<QuestionGubunVO> questGbList = questionGubunService.retrieveUsingList();
		model.addAttribute("questGbList", questGbList);
		
		
		return "manage/sampleQuestionManage";
	}
	
	
	/* 등록 */
	@RequestMapping("/createProcess.do")
	public String createSampQuestProcess(SampleQuestionVO sampQuestVO) {

		try {
			sampleQuestionService.create(sampQuestVO);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/sampQuest/retrievePagingList.do";
	}
	
	
	/* 일괄 등록 */
	@RequestMapping("/massiveCreateProcess.do")
	public String createMassiveHabit(MultipartHttpServletRequest request){
		MultipartFile excelFile = request.getFile("excelFile");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택해 주세요");
		}

		File destFile = new File("D:\\" + excelFile.getOriginalFilename());
		try {
			excelFile.transferTo(destFile);
			sampleQuestionService.createMassiveSampQuest(destFile);
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage(), e);
		}
		destFile.delete();

		return "redirect:/sampQuest/retrievePagingList.do";

	}
	
	/* 일괄 다운로드 */
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model) {

		// 출력할 리스트 가져오기
		List<SampleQuestionVO> sampQuestList;
		try {
			sampQuestList = sampleQuestionService.retrieveList();
			
			//Model 객체에 header, data
			List<String> header = new ArrayList<String>();
			header.add("SAMP_QUEST_SQ");
			header.add("SAMP_QUEST_CONTENT");
			header.add("SAMP_QUEST_ST");
			header.add("QUEST_GB_SQ");
			
			// excel 파일 data 설정
			List<Map<String, String>> data = new ArrayList<Map<String, String>>();
			
			for(int i = 0; i<sampQuestList.size(); i++) {
				Map<String, String> map = new HashMap<>();
				map.put("SAMP_QUEST_SQ", sampQuestList.get(i).getSampQuestSq());
				map.put("SAMP_QUEST_CONTENT", sampQuestList.get(i).getSampQuestContent());
				map.put("SAMP_QUEST_ST", sampQuestList.get(i).getSampQuestSt());
				map.put("QUEST_GB_SQ", sampQuestList.get(i).getQuestGbSq());
				data.add(map);
			}
			
			model.addAttribute("header",header);
			model.addAttribute("data",data);
			model.addAttribute("fileName","SAMPLE_QUESTION");
			model.addAttribute("sheetName","SAMPLE_QUESTION");
		} catch (Exception e) {
			e.printStackTrace();
		}

		
		return "excelView";
	}
	
	/* 샘플질문 수정 */
	@RequestMapping(path = "/updateProcess.do", method = { RequestMethod.POST })
	public String updateProcess(SampleQuestionVO sampQuestVO, Model model) {
		System.out.println("샘플 질문 수정 - sampQuestVO : " + sampQuestVO);

		int updateCnt;
		try {
			updateCnt = sampleQuestionService.update(sampQuestVO);
			System.out.println("샘플 질문  수정 - updateCnt : " + updateCnt);
			if (updateCnt == 1) {
				return "redirect:/sampQuest/retrievePagingList.do"; // 업데이트 성공시 리다이렉트
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "manage/sampleQuestionManage";
	}
	/* 샘플질문 검색*/
	@RequestMapping(path = "/retrieve.do")
	public String retrieve(String searchKeyword, Model model) {
		List<SampleQuestionVO> sampQuestList;
		try {
			sampQuestList = sampleQuestionService.retrieve(searchKeyword);
			model.addAttribute("sampQuestList",sampQuestList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "jsonView";
	}
	
	@RequestMapping(path = "/retrieveRandom.do")
	public String retrieveRandom(Model model){
		List<SampleQuestionVO> sampleQuestionList;
		try {
			sampleQuestionList = sampleQuestionService.retrieveList();
			List<SampleQuestionVO> randomQuestionList = new ArrayList<>();
			
			for (SampleQuestionVO sampleQuestionVO : sampleQuestionList) {
				if(sampleQuestionVO.getSampQuestSt().equals("Y")) {
					randomQuestionList.add(sampleQuestionVO);
				}
			}
			int randomInt = (int)(Math.random()*randomQuestionList.size());
			SampleQuestionVO sampleQuestionVO = randomQuestionList.get(randomInt);
			
			model.addAttribute("sampleQuestionVO",sampleQuestionVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "jsonView";
	}
	
	/* 질문 통계 화면 */
	@RequestMapping("/statistics.do")
	public String statistics() {
		return "manage/questionStatistic";
	}
	
	/* 질문 통계 데이터 - 직무별 */
	@RequestMapping("/retrieveQuestGbStatisticsList.do")
	public String retrieveQuestGbStatisticsList(String startDate, String endDate, String searchKeyword, Model model) {
		
		Map<String, String> statisticMap = new HashMap<>();
  		statisticMap.put("startDate", startDate);
		statisticMap.put("endDate", endDate);
		statisticMap.put("searchKeyword", searchKeyword);
		statisticMap.put("searchCondition", "0");

		List<SampleQuestionVO> resultList = null;
		try {
			resultList = sampleQuestionService.retrieveQuestGbUseCount(statisticMap);
			model.addAttribute("resultList", resultList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView"; 
	}
	
	/* 질문 통계 데이터 - 샘플질문별 */
	@RequestMapping("/retrieveQuestGbAndSampStatisticsList.do")
	public String retrieveQuestGbAndSampStatisticsList(String startDate, String endDate, String searchKeyword, Model model) {
		
		Map<String, String> statisticMap = new HashMap<>();
		statisticMap.put("startDate", startDate);
		statisticMap.put("endDate", endDate);
		statisticMap.put("searchKeyword", searchKeyword);
		statisticMap.put("searchCondition", "1");
		
		List<SampleQuestionVO> resultList = null;
		try {
			resultList = sampleQuestionService.retrieveQuestGbAndSampUseCount(statisticMap);
			model.addAttribute("resultList", resultList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView"; 
	}
}
