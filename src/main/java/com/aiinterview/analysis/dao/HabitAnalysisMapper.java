package com.aiinterview.analysis.dao;

import java.util.List;

import com.aiinterview.analysis.vo.HabitAnalysisVO;
import com.aiinterview.interview.vo.HabitVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("habitAnalysisMapper")
public interface HabitAnalysisMapper {
	
	public List<HabitAnalysisVO> retrieveList(String ansSq) throws Exception;
	

	/**
	 * 페이징처리를 위한 전체 habitVO 개수 구하는 메서드
	 * @param habitVO
	 * @return 전체 habitVO 개수
	 */
	public void create(HabitAnalysisVO habitanalysisVO) throws Exception;


	/**
	 * 최근 5회의 습관어 사용 횟수 리스트를 조회하는 메서드
	 * 성장 그래프
	 * @param memId
	 * @return
	 */
	public List<HabitAnalysisVO> retrieveGrowth(String memId) throws Exception;

	/**
	 * 최근 5회의 습관어별 사용 횟수 리스트를 조회하는 메서드
	 * 성장 그래프
	 * 바
	 * @param memId
	 * @return
	 */
	public List<HabitVO> retrieveCount(String memId) throws Exception;
	
}
