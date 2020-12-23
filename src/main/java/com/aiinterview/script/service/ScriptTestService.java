package com.aiinterview.script.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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
}
