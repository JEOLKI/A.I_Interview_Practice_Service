package com.aiinterview.script.dao;

import java.util.List;

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
	
}
