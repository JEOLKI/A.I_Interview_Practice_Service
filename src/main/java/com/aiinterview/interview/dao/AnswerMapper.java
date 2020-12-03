package com.aiinterview.interview.dao;

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
	 * @throws Exception
	 */
	public void create(AnswerVO answerVO) throws Exception;

}
