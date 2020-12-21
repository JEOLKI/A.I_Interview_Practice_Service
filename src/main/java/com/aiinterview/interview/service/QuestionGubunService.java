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
import com.aiinterview.interview.dao.QuestionGubunMapper;
import com.aiinterview.interview.vo.QuestionGubunVO;


@Service("questionGubunService")
public class QuestionGubunService {
	
	private static final Logger logger = LoggerFactory.getLogger(SampleQuestionService.class);
	
	@Resource(name="questionGubunMapper")
	private QuestionGubunMapper questionGubunMapper;

	/**
	 * 샘플질문 구분(직무) 목록을 조회하는 메서드
	 * @return questGbList
	 * @throws Exception 
	 */
	public List<QuestionGubunVO> retrieveList() throws Exception {
		logger.debug("질문 구분 리스트 조회 service");
		return questionGubunMapper.retrieveList();
	}

	/**
	 * 샘플질문 구분(직무)를 등록하는 메서드
	 * @param questGbVO
	 * @throws Exception 
	 */
	public void create(QuestionGubunVO questGbVO) throws Exception {
		questionGubunMapper.create(questGbVO);
	}

	/**
	 * 샘플질문 구분(직무)를 일괄등록하는 메서드
	 * @param destFile
	 * @throws Exception 
	 */
	public void createMassiveQuestGb(File destFile) throws Exception {
		ReadOption readOption = new ReadOption();
		  readOption.setFilePath(destFile.getAbsolutePath());
		  readOption.setOutputColumns("A","B","C");
		  readOption.setStartRow(2);

		  List<Map<String, String>> excelContent = ExcelRead.read(readOption);

		  QuestionGubunVO questGbVO = null;
		  for(Map<String, String> questGb : excelContent) {
			  questGbVO = new QuestionGubunVO();
			  questGbVO.setQuestGbContent(questGb.get("B"));
			  questGbVO.setQuestGbSt(questGb.get("C"));
			  
			  questionGubunMapper.create(questGbVO);
		  }
		
	}

	/**
	 * 샘플질문 구분(직무)를 수정하는 메서드
	 * @param questGbVO
	 * @return
	 */
	public int update(QuestionGubunVO questGbVO) throws Exception {
		int updateCnt = questionGubunMapper.update(questGbVO);
		return updateCnt;
	}
	
	/**
	 * 페이징처리를 위한 해당페이지 목록 조회하는 메서드
	 * @param questGbVO
	 * @return 해당페이지 목록
	 */
	public List<QuestionGubunVO> retrievePagingList(QuestionGubunVO questGbVO)throws Exception {
		return questionGubunMapper.retrievePagingList(questGbVO);
	}

	
	/**
	 * 페이징처리를 위한 전체 questGbVO 개수 구하는 메서드
	 * @param questGbVO
	 * @return 전체 questGbVO 개수
	 */
	public int retrievePagingListCnt(QuestionGubunVO questGbVO)throws Exception {
		return questionGubunMapper.retrievePagingListCnt(questGbVO);
	}


	/**
	 * 사용중인 샘플질문 구분(직무) 목록을 조회하는 메서드
	 * @return questGbList
	 * @throws Exception 
	 */
	public List<QuestionGubunVO> retrieveUsingList() throws Exception{
		return questionGubunMapper.retrieveUsingList();
	}

	/**
	 * 질문구분번호에 해당하는 질문구분 객체를 조회하는 메서드
	 * 업데이트용
	 * @param string
	 * @return
	 */
	public QuestionGubunVO retrieve(String questGbSq) throws Exception{
		return questionGubunMapper.retrieve(questGbSq);
	}


}
