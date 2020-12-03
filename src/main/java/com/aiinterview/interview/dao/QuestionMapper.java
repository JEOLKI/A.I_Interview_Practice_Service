package com.aiinterview.interview.dao;

import java.util.List;

import com.aiinterview.interview.vo.InterviewVO;
import com.aiinterview.interview.vo.QuestionVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("questionMapper")
public interface QuestionMapper {
	
	/**
	 * 해당하는 면접에 입력된 질문의 목록을 가져오는 메서드
	 * @param interviewSq
	 * @return 해당하는 몀접의 질문목록
	 * @throws Exception
	 */
	public List<QuestionVO> retrieveList(String interviewSq) throws Exception;
	
	/**
	 * 페이징처리를 위한 해당 페이지 목록 조회하는 메서드
	 * @param questionVO
	 * @return 해당페이지의 질문 목록
	 * @throws Exception
	 */
	public List<QuestionVO> retrievePagingList(QuestionVO questionVO) throws Exception;
	
	/**
	 * 페이징처리를 위한 갯수를 구하는 메서드
	 * @param questionVO
	 * @return 해당 질문의 갯수 
	 * @throws Exception
	 */
	public int retrievePagingListCnt(QuestionVO questionVO) throws Exception;
	
	/**
	 * 질문을 등록하기 위한메서드 
	 * @param questionVO
	 * @throws Exception
	 */
	public void create(QuestionVO questionVO) throws Exception;
	
}
