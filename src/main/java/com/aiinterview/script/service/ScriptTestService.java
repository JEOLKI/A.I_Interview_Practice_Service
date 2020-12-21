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
	 * 스크립트 테스트 결과를 출력하기 위한 메서드
	 * @param stVo
	 * @return
	 * @throws Exception
	 */
	public List<ScriptTestVO> retrieve (ScriptTestVO stVo)throws Exception{
		return scriptTestMapper.retrieve(stVo);
	}
}
