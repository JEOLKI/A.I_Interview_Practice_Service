package com.aiinterview.interview.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.aiinterview.common.util.excel.option.ReadOption;
import com.aiinterview.common.util.excel.read.ExcelRead;
import com.aiinterview.interview.dao.SampleQuestionMapper;
import com.aiinterview.interview.vo.QuestionGubunVO;
import com.aiinterview.interview.vo.SampleQuestionVO;

@Service("sampleQuestionService")
public class SampleQuestionService {
	
	private static final Logger logger = LoggerFactory.getLogger(SampleQuestionService.class);

	@Resource(name="sampleQuestionMapper")
	private SampleQuestionMapper sampleQuestionMapper;

	
	/**
	 * 페이징처리를 위한  해당페이지 샘플질문 리스트 추출
	 * @param sampQuestVO
	 * @return
	 */
	public List<SampleQuestionVO> retrievePagingList(SampleQuestionVO sampQuestVO) {
		logger.debug("샘플 질문 리스트 조회 service");
		return sampleQuestionMapper.retrievePagingList(sampQuestVO);
	}


	/**
	 * 페이징처리를 위한 샘플질문 총 개수를 구하는 메서드
	 * @param sampQuestVO
	 * @return 샘플질문 총 개수
	 */
	public int retrievePagingListCnt(SampleQuestionVO sampQuestVO) {
		return sampleQuestionMapper.retrievePagingListCnt(sampQuestVO);
	}


	/**
	 * 샘플질문을 등록하는 메서드
	 * @param questGbVO
	 */
	public void create(SampleQuestionVO sampQuestVO) {
		logger.debug("샘플질문 등록  service"); 
		sampleQuestionMapper.create(sampQuestVO);
		logger.debug("샘플질문 등록 service 후");
	}
	
	/**
	 * 샘플질문을 일괄등록하는 메서드
	 * @param destFile
	 * @throws Exception 
	 */
	public void createMassiveSampQuest(File destFile) throws Exception {
		ReadOption readOption = new ReadOption();
		  readOption.setFilePath(destFile.getAbsolutePath());
		  readOption.setOutputColumns("A","B","C","D");
		  readOption.setStartRow(2);

		  List<Map<String, String>> excelContent = ExcelRead.read(readOption);

		  SampleQuestionVO sampQuestVO = null;
		  for(Map<String, String> sampQuest : excelContent) {
			  sampQuestVO = new SampleQuestionVO();
			  sampQuestVO.setSampQuestContent(sampQuest.get("B"));
			  sampQuestVO.setSampQuestSt(sampQuest.get("C"));
			  sampQuestVO.setQuestGbSq(sampQuest.get("D"));
			  
			  sampleQuestionMapper.create(sampQuestVO);
		  }
		
	}

	
	/**
	 * 샘플질문 목록을 조회하는 메서드
	 * @return questGbList
	 * @throws Exception 
	 */
	public List<SampleQuestionVO> retrieveList() {
		return sampleQuestionMapper.retrieveList();
	}

	/**
	 * 샘플질문을 수정하는 메서드
	 * @param sampQuestVO
	 * @return
	 */
	public int update(SampleQuestionVO sampQuestVO) {
		return sampleQuestionMapper.update(sampQuestVO);
	}
	
	/**
	 * 샘플질문을 검색하는 메서드
	 * @param sampQuestContent
	 * @return
	 */
	public List<SampleQuestionVO> retrieve(String searchKeyword){
		return sampleQuestionMapper.retrieve(searchKeyword);
	}
}
