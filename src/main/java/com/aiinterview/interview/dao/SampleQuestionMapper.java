package com.aiinterview.interview.dao;

import java.util.List;
import java.util.Map;

import com.aiinterview.interview.vo.SampleQuestionVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("sampleQuestionMapper")
public interface SampleQuestionMapper {
	
	/**
	 * 페이징처리를 위한 해당페이지 목록 조회하는 메서드
	 * @param sampQuestVO
	 * @return 해당페이지 목록
	 */
	public List<SampleQuestionVO> retrievePagingList(SampleQuestionVO sampQuestVO)throws Exception;

	
	/**
	 * 페이징처리를 위한 전체 sampQuestVO 개수 구하는 메서드
	 * @param sampQuestVO
	 * @return 전체 sampQuestVO 개수
	 */
	public int retrievePagingListCnt(SampleQuestionVO sampQuestVO)throws Exception;

	
	/**
	 * 샘플질문을 등록하는 메서드
	 * @param sampQuestVO
	 */
	public void create(SampleQuestionVO sampQuestVO)throws Exception;

	
	/**
	 * 샘플질문 목록을 조회하는 메서드
	 * @return sampQuestList
	 */
	public List<SampleQuestionVO> retrieveList()throws Exception;


	/**
	 * 샘플질문을 수정하는 메서드
	 * @param sampQuestVO
	 * @return
	 */
	public int update(SampleQuestionVO sampQuestVO)throws Exception;
	
	/**
	 * 샘플질문을 검색하는 메서드
	 * @param sampQuestContent
	 * @return
	 */
	public List<SampleQuestionVO> retrieve(String searchKeyword)throws Exception;

	/**
	 * 직무별 샘플질문 사용 수 목록을 조회하는 메서드
	 * 통계용 (직무별)
	 * @param statisticMap
	 * @return
	 */
	public List<SampleQuestionVO> retrieveQuestGbUseCount(Map<String, String> statisticMap)throws Exception;

	/**
	 * 샘플질문별 사용 수 목록을 조회하는 메서드
	 * 통계용 (샘플질문별)
	 * @param statisticMap
	 * @return
	 */
	public List<SampleQuestionVO> retrieveQuestGbAndSampUseCount(Map<String, String> statisticMap)throws Exception;


	/**
	 * 샘플질문 번호에 해당하는 샘플질문 객체를 가져오는 메서드
	 * 업데이트용
	 * @param string
	 * @return
	 */
	public SampleQuestionVO retrieveOne(String sampQuestSq) throws Exception;

	/**
	 * 이미 존재하는 샘플질문을 등록하려 할때 업데이트로 데체할 메서드
	 * @param sampQuestVO
	 */
	public void createUpdate(SampleQuestionVO sampQuestVO);

}
