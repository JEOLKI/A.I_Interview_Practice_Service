package com.aiinterview.script.dao;

import java.util.List;
import java.util.Map;

import com.aiinterview.analysis.vo.ScriptGbAnalysisVO;
import com.aiinterview.script.vo.ScriptGubunVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("scriptGubunMapper")
public interface ScriptGubunMapper {
	
	/**
	 * 페이징처리를 위한 해당페이지 목록 조회하는 메서드
	 * @param ScriptGbVO
	 * @return 해당페이지 목록
	 */
	public List<ScriptGubunVO> retrievePagingList(ScriptGubunVO scriptGbVO) throws Exception;

	/**
	 * 페이징처리를 위한 전체 ScriptGbVO 개수 구하는 메서드
	 * @param ScriptGbVO
	 * @return 전체 ScriptGbVO 개수
	 */
	public int retrievePagingListCnt(ScriptGubunVO scriptGbVO) throws Exception;
	
	/**
	 * 스크립트 구분을 등록하는 메서드
	 * @return 
	 * @throws Exception
	 */
	public void create(ScriptGubunVO ScriptGbVO) throws Exception;
	
	/**
	 * 스크립트 구분 전체 리스트를 반환하는 메서드
	 * @return List<ScriptVo>
	 * @throws Exception
	 */
	public List<ScriptGubunVO> retrieveList() throws Exception;
	
	/**
	 * 스크립트 구분의 상태를 수정하는 메서드
	 * @param ScriptGbVO
	 * @return 성공 시 1, 실패 시 0
	 * @throws Exception
	 */
	public int update(ScriptGubunVO ScriptGbVO) throws Exception;
	

	/**
	 * 스크립트 구분 하나를 반환하는 메서드
	 * @param scriptGbSq
	 * @return ScriptVO
	 * @throws Exception
	 */
	public ScriptGubunVO retrieve(String scriptGbSq) throws Exception;

	/**
	 * 스크립트 구분을 검색하는 메서드
	 * @param searchKeyword
	 * @return
	 */
	public List<ScriptGubunVO> retrieveScriptGubunSearchList(String keyword) throws Exception;

//	/**
//	 * 스크립트 구분 도출 횟수 리스트를 조회하는 메서드
//	 * 스크립트 구분 통계용
//	 * @param statisticMap
//	 * @return
//	 * @throws Exception
//	 */
//	public List<ScriptGbAnalysisVO> retrieveStatisticsPagingList(Map<String, Object> statisticMap) throws Exception;
//
//	/**
//	 * 페이징 후 스크립트 구분 도출 횟수
//	 * @param statisticMap
//	 * @return
//	 * @throws Exception
//	 */
//	public int retrieveStatisticsPagingListCnt(Map<String, Object> statisticMap) throws Exception;
}
