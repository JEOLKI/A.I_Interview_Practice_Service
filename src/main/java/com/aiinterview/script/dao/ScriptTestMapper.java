package com.aiinterview.script.dao;

import java.util.List;

import com.aiinterview.script.vo.ScriptTestVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("scriptTestMapper")
public interface ScriptTestMapper {
	
//	/**
//	 * 스크립트 테스트 하나를 반환하는 메서드
//	 * @param scrtiptTestSq
//	 * @return scriptTestVO
//	 * @throws Exception
//	 */
//	public ScriptTestVO retrieve(String scrtiptTestSq) throws Exception;
	
//	/**
//	 * 스크립트 테스트 전체 리스트를 반환하는 메서드
//	 * @return List<ScriptTestVo>
//	 * @throws Exception
//	 */
//	public List<ScriptTestVO> retrieveList() throws Exception;
	
	/**
	 * 스크립트 테스트를 추가하는 메서드
	 * @return 
	 * @throws Exception
	 */
	public void create(ScriptTestVO ScriptTestVO) throws Exception;
	
//	/**
//	 * 스크립트 테스트의 활성 상태를 수정하는 메서드
//	 * @param ScriptTestVO
//	 * @return 성공 시 1, 실패 시 0
//	 * @throws Exception
//	 */
//	public int update(ScriptTestVO ScriptTestVO) throws Exception;
	
//	/**
//	 * 스크립트 테스트의 검색 목록을 반환하는 메서드
//	 * @param keyword
//	 * @return ScriptTestVO
//	 * @throws Exception
//	 */
//	public List<ScriptTestVO> retrieveSearchList(String keyword) throws Exception;

	
}
