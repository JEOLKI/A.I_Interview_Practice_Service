package com.aiinterview.interview.dao;

import java.util.List;
import java.util.Map;

import com.aiinterview.analysis.vo.TalentAnalysisVO;
import com.aiinterview.interview.vo.HabitVO;
import com.aiinterview.interview.vo.TalentVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("talentMapper")
public interface TalentMapper {

	/**
	 * 인재상을 등록하는 메서드
	 * @param talentVO
	 * @return 1 : 등록 성공 / 0 : 등록 실패
	 * @throws Exception
	 */
	public void create(TalentVO talentVO) throws Exception;

	/**
	 * 인재상 목록 전체를 조회하는 메서드
	 * @return 인재상 목록
	 */
	public List<TalentVO> retrieveList() throws Exception;

	/**
	 * 인재상을 수정하는 메서드
	 * @param talentVO
	 * @return 1: 수정 성공 / 0 : 수정 실패
	 */
	public int update(TalentVO talentVO) throws Exception;

	/**
	 * 페이징처리를 위한 해당페이지 목록 조회하는 메서드
	 * @param talentVO
	 * @return 해당페이지 목록
	 */
	public List<TalentVO> retrievePagingList(TalentVO talentVO) throws Exception;

	/**
	 * 페이징처리를 위한 전체 talentVO 개수 구하는 메서드
	 * @param talentVO
	 * @return 전체 talentVO 개수
	 */
	public int retrievePagingListCnt(TalentVO talentVO) throws Exception;

	/**
	 * 사용중인 인재상 목록 조회를 위한 메서드
	 * @return
	 */
	public List<TalentVO> retrieveUsingList() throws Exception;

	/**
	 * 인재상 하나를 조회하는 메서드
	 * @param talentSq
	 * @return
	 */
	public TalentVO retrieve(String talentSq) throws Exception;

	/**
	 * 인재상 도출 횟수 리스트를 조회하는 메서드
	 * 인재상 통계용
	 * @param statisticMap 
	 * @return
	 */
	public List<TalentAnalysisVO> retrieveStatisticsList(Map<String, String> statisticMap) throws Exception;

	/**
	 * 이미 있는 인재상을 등록하려고 할 때 업데이드로 대체하는 메서드
	 * @param talentVO
	 */
	public void createUpdate(TalentVO talentVO);

}
