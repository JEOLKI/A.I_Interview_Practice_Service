package com.aiinterview.script.dao;

import java.util.List;
import java.util.Map;

import com.aiinterview.script.vo.ScriptVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("scriptMapper")
public interface ScriptMapper {
	
	/**
	 * 스크립트를 등록하는 메서드
	 * @return String
	 * @throws Exception
	 */
	public void create(ScriptVO ScriptVO) throws Exception;
	
	/**
	 * 스크립트 전체 리스트를 반환하는 메서드
	 * @return List<ScriptVo>
	 * @throws Exception
	 */
	public List<ScriptVO> retrieveList() throws Exception;
	
	/**
	 * 스크립트의 활성 상태를 수정하는 메서드
	 * @param ScriptVO
	 * @return 성공 시 1, 실패 시 0
	 * @throws Exception
	 */
	public int update(ScriptVO ScriptVO) throws Exception;
	
	/**
	 * 스크립트 하나를 반환하는 메서드
	 * @param scriptSq
	 * @return ScriptVO
	 * @throws Exception
	 */
	public ScriptVO retrieve(String scriptSq) throws Exception;

	/**
	 * 검색한 스크립트의 리스트를 조회하는 메서드
	 * @param keyword
	 * @return
	 */
	public List<ScriptVO> retrieveScriptSearchList(String keyword) throws Exception;
	
	/**
	 * 스크립트 구분 sq에 맞는 스크립트 전체리스트를 반환하는 메서드
	 * @return List<ScriptVo>
	 * @throws Exception
	 */
	public List<ScriptVO> retrieveSelectList(String scriptGbSq) throws Exception;

	/**
	 * 스크립트 구분 별 스크립트 목록을 조회하는 메서드
	 * @param retrieveMap
	 * @return
	 * @throws Exception
	 */
	public List<ScriptVO> retrieveScriptGbScriptPagingList(Map<String, Object> retrieveMap) throws Exception;

	/**
	 * 스크립트 구분 별 스크립트의 총 개수
	 * @param scriptVO
	 * @return 스크립트 구분별 스크립트의 총 개수
	 */
	public int retrieveScriptGbScriptPagingListCnt(ScriptVO scriptVO) throws Exception;
	
	
//	/**
//	 * 페이징 처리 후 해당 페이지의 스크립트 리스트를 반환하는 메서드
//	 * @param scriptVO
//	 * @return List<ScriptVO>
//	 * @throws Exception
//	 */
//	public List<ScriptVO> retrievePagingList(ScriptVO scriptVO) throws Exception; 
//	
//	/**
//	 * 스크립트의 총 갯수를 반환하는 메서드
//	 * @param scriptVO
//	 * @return int
//	 * @throws Exception
//	 */
//	public int retrievePagingListCnt(ScriptVO scriptVO) throws Exception;
	
}
