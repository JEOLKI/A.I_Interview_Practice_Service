package com.aiinterview.script.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.script.dao.ScriptMapper;
import com.aiinterview.script.vo.ScriptVO;

@Service("scriptService")
public class ScriptService {
	
	@Resource(name = "scriptMapper")
	private ScriptMapper scriptMapper;

	/**
	 * 스크립트 하나를 반환하는 메서드
	 * @param scriptSq
	 * @return ScriptVO
	 * @throws Exception
	 */
	public ScriptVO retrieve(String scriptSq) throws Exception{
		return scriptMapper.retrieve(scriptSq);
	}
	
	/**
	 * 스크립트 전체 리스트를 반환하는 메서드
	 * @return List<scriptVo>
	 * @throws Exception
	 */
	public List<ScriptVO> retrieveList() throws Exception{
		return scriptMapper.retrieveList();
	}
	
//	/**
//	 * 스크립트의 총 갯수를 반환하는 메서드
//	 * @param scriptVO
//	 * @return int
//	 * @throws Exception
//	 */
//	public int retrievePagingListCnt(ScriptVO scriptVO) throws Exception{
//		return scriptMapper.retrievePagingListCnt(scriptVO);
//	}
//	
//	/**
//	 * 전체 스크립트를 페이징 처리 후 한 페이지당 보여지는 스크립트의 리스트
//	 * @return List<ScriptVO>
//	 * @throws Exception
//	 */
//	public List<ScriptVO> retrievePageList() throws Exception{
//		return scriptMapper.retrievePageList();
//	}
//	
//	/**
//	 * 특정 스크립트 구분 별로 페이징 처리 후 한 페이지당 보여지는 스크립트의 리스트
//	 * @return List<ScriptVO>
//	 * @throws Exception
//	 */
//	public List<ScriptVO> retrievePageList(String scriptSq) throws Exception{
//		return scriptMapper.retrievePageList(scriptSq);
//	}
	
	/**
	 * 스크립트를 추가하는 메서드
	 * @return String
	 * @throws Exception
	 */
	public void create(ScriptVO ScriptVO) throws Exception{
		scriptMapper.create(ScriptVO);
	}
	
	/**
	 * 스크립트의 활성 상태를 수정하는 메서드
	 * @param ScriptGbVO
	 * @return 성공 시 1, 실패 시 0
	 * @throws Exception
	 */
	public int update(ScriptVO ScriptVO) throws Exception{
		return scriptMapper.update(ScriptVO);
	}
}
