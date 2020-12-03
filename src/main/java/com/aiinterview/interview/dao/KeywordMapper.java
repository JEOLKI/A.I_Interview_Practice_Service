package com.aiinterview.interview.dao;

import java.util.List;

import com.aiinterview.interview.vo.KeywordVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("keywordMapper")
public interface KeywordMapper {
	/**
	 * 페이징처리를 위한 해당페이지 목록 조회하는 메서드
	 * @param keywordVO
	 * @return 해당페이지 목록
	 */
	public List<KeywordVO> retrievePagingList(KeywordVO keywordVO);

	
	/**
	 * 페이징처리를 위한 전체 keywordVO 개수 구하는 메서드
	 * @param keywordVO
	 * @return 전체 keywordVO 개수
	 */
	public int retrievePagingListCnt(KeywordVO keywordVO);

	
	/**
	 * 키워드를 등록하는 메서드
	 * @param keywordVO
	 */
	public String create(KeywordVO keywordVO);

	
	/**
	 * 키워드 목록을 조회하는 메서드
	 * @return keywordVO
	 */
	public List<KeywordVO> retrieveList();


	/**
	 * 키워드를 수정하는 메서드
	 * @param keywordVO
	 * @return
	 */
	public int update(KeywordVO keywordVO);


	/**
	 * 인재상별 키워드 목록을 조회하는 메서드
	 * @param talentSq
	 * @return
	 */
	public List<KeywordVO> retrieveTalentKeywordList(String talentSq);
}
