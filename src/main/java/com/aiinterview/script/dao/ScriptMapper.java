package com.aiinterview.script.dao;

import java.util.List;

import com.aiinterview.script.vo.ScriptVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("scriptMapper")
public interface ScriptMapper {
	
	/**
	 * 스크립트 하나를 반환하는 메서드
	 * @param scriptSq
	 * @return ScriptVO
	 * @throws Exception
	 */
	public ScriptVO retrieve(String scriptSq) throws Exception;
	
	/**
	 * 스크립트 전체 리스트를 반환하는 메서드
	 * @return List<ScriptVo>
	 * @throws Exception
	 */
	public List<ScriptVO> retrieveList() throws Exception;

//	/**
//	 * 스크립트의 총 갯수를 반환하는 메서드
//	 * @param scriptVO
//	 * @return int
//	 * @throws Exception
//	 */
//	public int retrievePagingListCnt(ScriptVO scriptVO) throws Exception;
//	
//	/**
//	 * 전체 스크립트를 페이징 처리 후 한 페이지당 보여지는 스크립트의 리스트
//	 * @return List<ScriptVO>
//	 * @throws Exception
//	 */
//	public List<ScriptVO> retrievePageList() throws Exception; 
//	
//	/**
//	 * 특정 스크립트 구분 별로 페이징 처리 후 한 페이지당 보여지는 스크립트의 리스트
//	 * @return List<ScriptVO>
//	 * @throws Exception
//	 */
//	public List<ScriptVO> retrievePageList(String scriptGbSq) throws Exception;
	
	/**
	 * 스크립트를 추가하는 메서드
	 * @return String
	 * @throws Exception
	 */
	public void create(ScriptVO ScriptVO) throws Exception;
	
	/**
	 * 스크립트의 활성 상태를 수정하는 메서드
	 * @param ScriptVO
	 * @return 성공 시 1, 실패 시 0
	 * @throws Exception
	 */
	public int update(ScriptVO ScriptVO) throws Exception;
}
