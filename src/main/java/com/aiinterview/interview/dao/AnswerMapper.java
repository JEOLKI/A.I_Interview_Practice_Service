package com.aiinterview.interview.dao;

import java.util.List;

import com.aiinterview.interview.vo.AnswerVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("answerMapper")
public interface AnswerMapper {
	
	/**
	 * 해당하는 질문의 답변을 보여주기위한 메서드
	 * @param questSq 해당 질문의 번호
	 * @return 해당질문의 AnswerVO 객체
	 * @throws Exception
	 */
	public AnswerVO retrieve(String questSq) throws Exception;
	
	/**
	 * 답변을 등록하기 위한 메서드
	 * @param answerVO 해당 답변의 정보를 담은 객체
	 * @return 
	 * @throws Exception
	 */
	public void create(AnswerVO answerVO) throws Exception;

	/**
	 * 최근 5회의 답변 속도 평균 리스트를 조회하는 메서드
	 * 성장 그래프용
	 * @param memId
	 * @return
	 */
	public List<AnswerVO> retrieveSpeedGrowth(String memId);

}
