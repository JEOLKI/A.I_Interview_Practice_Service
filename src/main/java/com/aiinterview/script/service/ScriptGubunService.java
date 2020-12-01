package com.aiinterview.script.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.script.dao.ScriptGubunMapper;
import com.aiinterview.script.vo.ScriptGubunVO;

@Service("scriptGubunService")
public class ScriptGubunService {
	
	@Resource(name = "scriptGubunMapper")
	private ScriptGubunMapper scriptGubunMapper;

	/**
	 * 스크립트 구분 하나를 반환하는 메서드
	 * @param scriptGbSq
	 * @return ScriptGubunVO
	 * @throws Exception
	 */
	public ScriptGubunVO retrieve(String scriptGbSq) throws Exception{
		return scriptGubunMapper.retrieve(scriptGbSq);
	}
	
	/**
	 * 스크립트 구분 전체 리스트를 반환하는 메서드
	 * @return List<ScriptGubunVo>
	 * @throws Exception
	 */
	public List<ScriptGubunVO> retrieveList() throws Exception{
		return scriptGubunMapper.retrieveList();
	}
	
	/**
	 * 스크립트 구분을 추가하는 메서드
	 * @return
	 * @throws Exception
	 */
	public void create(ScriptGubunVO ScriptGbVO) throws Exception{
		scriptGubunMapper.create(ScriptGbVO);
	}
	
	/**
	 * 스크립트 구분의 활성 상태를 수정하는 메서드
	 * @param ScriptGbVO
	 * @return 성공 시 1, 실패 시 0
	 * @throws Exception
	 */
	public int update(ScriptGubunVO ScriptGbVO) throws Exception{
		return scriptGubunMapper.update(ScriptGbVO);
	}
}
