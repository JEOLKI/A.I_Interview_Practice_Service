package com.aiinterview.script.dao;

import java.util.List;
import java.util.Map;

import com.aiinterview.script.vo.ScriptTestVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("scriptTestMapper")
public interface ScriptTestMapper {

	/**
	 * 스크립트 테스트를 추가하는 메서드
	 * @return 
	 * @throws Exception
	 */
	public void create(ScriptTestVO scriptTestVO) throws Exception;

	/**
	 * 특정 멤버의 script Test 결과를 반환하는 메서드
	 * @param memId
	 * @return
	 * @throws Exception
	 */
	public List<ScriptTestVO> retrieveList(String memId) throws Exception;

	/**
	 * 스크립트 테스트 일치도 구하는 메서드
	 * @param testScoreMap
	 * @return
	 */
	public int retrieveScore(Map<String, String> testScoreMap);

	/**
	 * 스크립트 구분 도출 횟수 및 순위 리스트를 조회하는 메서드
	 * 스크립트 구분 통계용
	 * @param statisticMap
	 * @return
	 * @throws Exception
	 */
	public List<ScriptTestVO> retrieveRankingList(Map<String, String> statisticMap) throws Exception;

	/**
	 * 스크립트 구분 별 테스트 점수를 조회하는 메서드
	 * @param testScoreMaps
	 * @return
	 * @throws Exception
	 */
	public List<ScriptTestVO> retrieveScoreList(Map<String, String> testScoreMap) throws Exception;
}
