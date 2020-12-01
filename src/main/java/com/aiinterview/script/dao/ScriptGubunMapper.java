package com.aiinterview.script.dao;

import java.util.List;

import com.aiinterview.script.vo.ScriptGubunVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("scriptGubunMapper")
public interface ScriptGubunMapper {
	
	/**
	 * 스크립트 구분 하나를 반환하는 메서드
	 * @param scriptGbSq
	 * @return ScriptVO
	 * @throws Exception
	 */
	public ScriptGubunVO retrieve(String scriptGbSq) throws Exception;
	
	/**
	 * 스크립트 구분 전체 리스트를 반환하는 메서드
	 * @return List<ScriptVo>
	 * @throws Exception
	 */
	public List<ScriptGubunVO> retrieveList() throws Exception;
	
	
	/**
	 * 스크립트 구분을 추가하는 메서드
	 * @return 
	 * @throws Exception
	 */
	public void create(ScriptGubunVO ScriptGbVO) throws Exception;
	
	/**
	 * 스크립트 구분의 활성 상태를 수정하는 메서드
	 * @param ScriptGbVO
	 * @return 성공 시 1, 실패 시 0
	 * @throws Exception
	 */
	public int update(ScriptGubunVO ScriptGbVO) throws Exception;
}
