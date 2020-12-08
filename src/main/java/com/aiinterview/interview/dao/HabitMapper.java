package com.aiinterview.interview.dao;


import java.util.List;

import com.aiinterview.interview.vo.HabitVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("habitMapper")
public interface HabitMapper {

	/**
	 * 습관어를 등록하는 메서드
	 * @param habitVO
	 * @return 1 : 등록 성공 / 0 : 등록 실패
	 * @throws Exception
	 */
	public void create(HabitVO habitVO) throws Exception;

	/**
	 * 습관어 목록 전체를 조회하는 메서드
	 * 목록 출력용(엑셀)
	 * @return 습관어 목록
	 */
	public List<HabitVO> retrieveList() throws Exception;
	
	/**
	 * 해당 번호의 습관어 내용을 조회하는 메서드
	 * 리포트 출력용
	 * @param habitSq
	 * @return
	 * @throws Exception
	 */
	public String retrieve(String habitSq) throws Exception;
	 
	
	/**
	 * 사용중인 습관어 리스트를 조회하는 메서드
	 * 분석용
	 * @return
	 * @throws Exception
	 */
	public List<HabitVO> retrieveUsingList() throws Exception;

	/**
	 * 습관어를 수정하는 메서드
	 * @param habitVO
	 * @return 1: 수정 성공 / 0 : 수정 실패
	 */
	public int update(HabitVO habitVO) throws Exception;

	/**
	 * 페이징처리를 위한 해당페이지 목록 조회하는 메서드
	 * @param HabitVO
	 * @return 해당페이지 목록
	 */
	public List<HabitVO> retrievePagingList(HabitVO habitVO) throws Exception;

	/**
	 * 페이징처리를 위한 전체 habitVO 개수 구하는 메서드
	 * @param habitVO
	 * @return 전체 habitVO 개수
	 */
	public int retrievePagingListCnt(HabitVO habitVO) throws Exception;

	
}
