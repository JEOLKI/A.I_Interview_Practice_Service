package com.aiinterview.interview.dao;

import java.util.List;
import java.util.Map;

import com.aiinterview.interview.vo.KeywordVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("keywordMapper")
public interface KeywordMapper {
	

	/**
	 * 인재상별 키워드 목록을 조회하는 메서드
	 * @param keywordVO
	 * @return
	 */
	public List<KeywordVO> retrieveTalentKeywordPagingList(KeywordVO keywordVO)throws Exception;

	/**
	 * 인재상별 키워드 수 조회하는 메서드
	 * @param keywordVO
	 * @return
	 */
	public int retrieveTalentKeywordPagingListCnt(KeywordVO keywordVO)throws Exception;

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
	public List<KeywordVO> retrieveTalentKeywordAllList(String talentSq)throws Exception;


	/**
	 * 해당 번호의 키워드 내용을 조회하는 메서드
	 * 다운로드용
	 * @param talentSq
	 * @return
	 */
	public String retrieveKeywordContent(String keywordSq)throws Exception;


	
}
