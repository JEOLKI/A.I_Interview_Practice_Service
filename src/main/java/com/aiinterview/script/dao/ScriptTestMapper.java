package com.aiinterview.script.dao;

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
}
