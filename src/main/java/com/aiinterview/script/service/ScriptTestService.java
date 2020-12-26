package com.aiinterview.script.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.script.dao.ScriptMapper;
import com.aiinterview.script.dao.ScriptTestMapper;
import com.aiinterview.script.vo.ScriptTestVO;

@Service("scriptTestService")
public class ScriptTestService {
	
	@Resource(name = "scriptTestMapper")
	private ScriptTestMapper scriptTestMapper;

	/**
	 * 스크립트 테스트를 추가하는 메서드
	 * @return String
	 * @throws Exception
	 */
	public void create(ScriptTestVO scriptTestVO) throws Exception{
		scriptTestMapper.create(scriptTestVO);
	}
	
	/**
	 * 특정 멤버의 script Test 결과를 반환하는 메서드
	 * @param memId
	 * @return
	 * @throws Exception
	 */
	public List<ScriptTestVO> retrieveList(String memId) throws Exception{
		return scriptTestMapper.retrieveList(memId);
	}

	/**
	 * 스크립트 테스트 일치도 구하는 메서드
	 * @param testScoreMap
	 * @return
	 */
	public int retrieveScore(Map<String, String> testScoreMap) {
		return scriptTestMapper.retrieveScore(testScoreMap);
	}

	/**
	 * 스크립트 구분별 스크립트 도출 횟수 및 순위 리스트를 조회하는 메서드
	 * 스크립트 구분 통계용
	 * @param statisticMap
	 * @return
	 * @throws Exception
	 */
	public List<ScriptTestVO> retrieveRankingList(Map<String, String> statisticMap) throws Exception{
		return scriptTestMapper.retrieveRankingList(statisticMap);
	}

	/**
	 * 스크립트 구분 별 테스트 점수를 조회하는 메서드
	 * @param testScoreMap
	 * @return
	 * @throws Exception
	 */
	public List<ScriptTestVO> retrieveScoreList(Map<String, String> testScoreMap) throws Exception{
		return scriptTestMapper.retrieveScoreList(testScoreMap);
	}
}
