package com.aiinterview.interview.dao;

import java.util.List;

import com.aiinterview.interview.vo.QuestionGubunVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("questionGubunMapper")
public interface QuestionGubunMapper {

	/**
	 * 샘플질문 구분(직무) 목록을 조회하는 메서드
	 * @return questGbList
	 */
	public List<QuestionGubunVO> retrieveList() throws Exception;

	/**
	 * 샘플질문 구분(직무)를 등록하는 메서드
	 * @param questGbVO
	 */
	public void create(QuestionGubunVO questGbVO)throws Exception;

	/**
	 * 샘플질문 구분(직무)를 수정하는 메서드
	 * @param questGbVO
	 * @return
	 */
	public int update(QuestionGubunVO questGbVO);
	
	/**
	 * 샘플질문 구분(직무) 검색 목록을 조회하는 메서드
	 * @return questGbList
	 */
	public List<QuestionGubunVO> retrieveQuestGbSearchList(String keyword) throws Exception;

	
	/**
	 * 페이징처리를 위한 해당페이지 목록 조회하는 메서드
	 * @param questGbVO
	 * @return 해당페이지 목록
	 */
	public List<QuestionGubunVO> retrievePagingList(QuestionGubunVO questGbVO);

	
	/**
	 * 페이징처리를 위한 전체 questGbVO 개수 구하는 메서드
	 * @param questGbVO
	 * @return 전체 questGbVO 개수
	 */
	public int retrievePagingListCnt(QuestionGubunVO questGbVO);

	/**
	 * 사용중인 샘플질문 구분(직무) 목록을 조회하는 메서드
	 * @return questGbList
	 * @throws Exception 
	 */
	public List<QuestionGubunVO> retrieveUsingList();

}
