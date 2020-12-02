package com.aiinterview.interview.web;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.aiinterview.interview.service.QuestionGubunService;
import com.aiinterview.interview.service.SampleQuestionService;
import com.aiinterview.interview.vo.QuestionGubunVO;
import com.aiinterview.interview.vo.SampleQuestionVO;

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
	public String retrievePagingList( QuestionGubunVO questGbVO, SampleQuestionVO sampQuestVO,Model model) throws Exception {
		
		logger.debug("페이징 컨트롤러  sampQuestVO : {}",sampQuestVO);
		/** EgovPropertyService.sample */
		sampQuestVO.setPageUnit(propertiesService.getInt("pageUnit"));
		sampQuestVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(sampQuestVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(sampQuestVO.getPageUnit());
		paginationInfo.setPageSize(sampQuestVO.getPageSize());
		
		logger.debug("paginationInfo : "+ paginationInfo);

		
		sampQuestVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		sampQuestVO.setLastIndex(paginationInfo.getLastRecordIndex());
		sampQuestVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<SampleQuestionVO> resultList = sampleQuestionService.retrievePagingList(sampQuestVO);
		logger.debug("페이징 resultList : "+resultList);
		model.addAttribute("resultList", resultList);

		int totCnt = sampleQuestionService.retrievePagingListCnt(sampQuestVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		
		/* 질문 구분 목록 추출 */
		List<QuestionGubunVO> questGbList = questionGubunService.retrieveUsingList();
		model.addAttribute("questGbList", questGbList);
		
		
		return "question/sampleQuestionManage";
	}
	
	
	/* 등록 */
	@RequestMapping("/createProcess.do")
	public String createSampQuestProcess(SampleQuestionVO sampQuestVO) throws Exception {

		logger.debug("샘플 질문 등록 : {}", sampQuestVO);

		sampleQuestionService.create(sampQuestVO);

		return "redirect:/sampQuest/retrievePagingList.do";
	}
	
	
	/* 일괄 등록 */
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

		sampleQuestionService.createMassiveSampQuest(destFile);

		destFile.delete();

		return "redirect:/sampQuest/retrievePagingList.do";

	}
}
