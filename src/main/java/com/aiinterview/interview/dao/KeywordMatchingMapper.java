package com.aiinterview.interview.dao;

import java.util.Map;

import com.aiinterview.interview.vo.KeywordMatchingVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("keywordMatchingMapper")
public interface KeywordMatchingMapper {

	/**
	 * 키워드매칭을 생성하기 위한 메서드 
	 * @param keywordMatchingVO
	 * @return
	 */
	public String create(KeywordMatchingVO keywordMatchingVO);

	/**
	 * 키워드매칭을 수정하기 위한 메서드
	 * @param keywordMatchingVO
	 * @return
	 */
	public int update(KeywordMatchingVO keywordMatchingVO);

	
	/**
	 * 해당인재상의 키워드를 삭제하는 메서드
	 * @param deleteMap
	 * @return
	 */
	public int delete(Map<String, String> deleteMap);
	
	
	

}
