package com.aiinterview.interview.dao;

import java.util.List;

import com.aiinterview.interview.vo.SampleQuestionVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("sampleQuestionMapper")
public interface SampleQuestionMapper {
	
	/**
	 * 페이징처리를 위한 해당페이지 목록 조회하는 메서드
	 * @param sampQuestVO
	 * @return 해당페이지 목록
	 */
	public List<SampleQuestionVO> retrievePagingList(SampleQuestionVO sampQuestVO);

	
	/**
	 * 페이징처리를 위한 전체 sampQuestVO 개수 구하는 메서드
	 * @param sampQuestVO
	 * @return 전체 sampQuestVO 개수
	 */
	public int retrievePagingListCnt(SampleQuestionVO sampQuestVO);

	/**
	 * 샘플질문을 등록하는 메서드
	 * @param sampQuestVO
	 */
	public void create(SampleQuestionVO sampQuestVO);

	
	/**
	 * 샘플질문 목록을 조회하는 메서드
	 * @return sampQuestList
	 */
	public List<SampleQuestionVO> retrieveList();

}
