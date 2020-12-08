package com.aiinterview.script.service;

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
	
	
//	/**
//	 * 스크립트 하나를 반환하는 메서드
//	 * @param scriptTestSq
//	 * @return scriptTestVO
//	 * @throws Exception
//	 */
//	public ScriptTestVO retrieve(String scriptTestSq) throws Exception{
//		return scriptTestMapper.retrieve(scriptTestSq);
//	}
//	
//	/**
//	 * 스크립트 전체 리스트를 반환하는 메서드
//	 * @return List<scriptTestVo>
//	 * @throws Exception
//	 */
//	public List<ScriptTestVO> retrieveList() throws Exception{
//		return scriptTestMapper.retrieveList();
//	}
//	
//	/**
//	 * 스크립트 구분 sq에 맞는 스크립트 전체리스트를 반환하는 메서드
//	 * @return List<scriptTestVo>
//	 * @throws Exception
//	 */
//	public List<ScriptTestVO> retrieveSelectList(String scriptTestGbSq) throws Exception{
//		return scriptTestMapper.retrieveSelectList(scriptTestGbSq);
//	}
	
//	/**
//	 * 스크립트의 총 갯수를 반환하는 메서드
//	 * @param scriptTestVO
//	 * @return int
//	 * @throws Exception
//	 */
//	public int retrievePagingListCnt(scriptTestVO scriptTestVO) throws Exception{
//		return scriptTestMapper.retrievePagingListCnt(scriptTestVO);
//	}
//	
//	/**
//	 * 전체 스크립트를 페이징 처리 후 한 페이지당 보여지는 스크립트의 리스트
//	 * @return List<scriptTestVO>
//	 * @throws Exception
//	 */
//	public List<scriptTestVO> retrievePageList() throws Exception{
//		return scriptTestMapper.retrievePageList();
//	}
//	
//	/**
//	 * 특정 스크립트 구분 별로 페이징 처리 후 한 페이지당 보여지는 스크립트의 리스트
//	 * @return List<scriptTestVO>
//	 * @throws Exception
//	 */
//	public List<scriptTestVO> retrievePageList(String scriptTestSq) throws Exception{
//		return scriptTestMapper.retrievePageList(scriptTestSq);
//	}
}
