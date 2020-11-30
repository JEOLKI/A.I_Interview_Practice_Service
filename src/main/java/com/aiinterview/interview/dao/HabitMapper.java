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
	 * @return 습관어 목록
	 */
	public List<HabitVO> retrieveHabitList();

	/**
	 * 습관어를 수정하는 메서드
	 * @param habitVO
	 * @return 1: 수정 성공 / 0 : 수정 실패
	 */
	public int update(HabitVO habitVO);
	
}
