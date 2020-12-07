package com.aiinterview.interview.dao;

import java.util.List;
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

//////////////////////////////////// 이하 모델링 수정 이후 //////////////////////////////////////	

	/**
	 * 해당인재상의 키워드를 삭제하는 메서드
	 * @param deleteMap
	 * @return
	 */
	public int delete(Map<String, String> deleteMap);

	/**
	 * 키워드를 인재상에 매칭하는 메서드
	 * @param createMap
	 * @return
	 */
	public String create(Map<String, String> createMap) throws Exception;

	/**
	 * 해당 매칭을 조회하는 메서드
	 * @param createMap
	 * @return
	 */
	public int retrieve(Map<String, String> createMap) throws Exception;

	/**
	 * 키워드 매칭 리스트를 조회하는 메서드
	 * @return
	 */
	public List<KeywordMatchingVO> retrieveList() throws Exception;
	
	
	

}
