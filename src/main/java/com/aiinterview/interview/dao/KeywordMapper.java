package com.aiinterview.interview.dao;

import java.util.List;
import java.util.Map;

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
	 * @param retrieveMap
	 * @return
	 */
	public List<KeywordVO> retrieveTalentKeywordPagingList(Map<String, Object> retrieveMap);

	
/////////////////////////////////// 이하 모델링 수정 이후 ///////////////////////////////////

	/**
	 * 해당 내용의 키워드 존재여부를 조회하는 메서드
	 * @param keywordContent
	 * @return
	 */
	public int retrieve(String keywordContent) throws Exception;

	/**
	 * 해당 내용의 키워드를 생성하는 메서드
	 * @param keywordContent
	 * @return
	 */
	public void create(String keywordContent) throws Exception;

	/**
	 * 해당내용의 키워드를 조회하는 메서드
	 * @param keywordContent
	 * @return
	 */
	public int retrieveKeywordSq(String keywordContent) throws Exception;


	/**
	 * 인재상별 모든 키워드 리스트 조회하는 메서드 
	 * 다운로드용
	 * @param talentSq
	 * @return
	 */
	public List<KeywordVO> retrieveTalentKeywordAllList(String talentSq);
}
