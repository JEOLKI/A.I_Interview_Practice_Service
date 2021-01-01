package com.aiinterview.script.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.common.util.excel.option.ReadOption;
import com.aiinterview.common.util.excel.read.ExcelRead;
import com.aiinterview.script.dao.ScriptMapper;
import com.aiinterview.script.vo.ScriptVO;

@Service("scriptService")
public class ScriptService {
	@Resource(name = "scriptMapper")
	private ScriptMapper scriptMapper;
	
	/**
	 * 스크립트 단일 등록 메서드
	 * @return String
	 * @throws Exception
	 */
	public void create(ScriptVO ScriptVO) throws Exception{
		scriptMapper.create(ScriptVO);
	}
	
	/**
	 * 스크립트 일괄 등록 메서드
	 * @param destFile
	 * @throws Exception
	 */
	public void createMassiveScript(File destFile, String scriptGbSq) throws Exception{
		ReadOption readOption = new ReadOption();
		  readOption.setFilePath(destFile.getAbsolutePath());
		  readOption.setOutputColumns("A","B");
		  readOption.setStartRow(2);
	
		  List<Map<String, String>> excelContent = ExcelRead.read(readOption);
		  List<ScriptVO> scriptList = scriptMapper.retrieveSelectList(scriptGbSq);
		  List<String> contentList = new ArrayList<>();
		  for(ScriptVO exist : scriptList) {
			  contentList.add(exist.getScriptContent());
		  }
		  
		  ScriptVO scriptVO = null;
		  for(Map<String, String> script : excelContent) {
			  scriptVO = new ScriptVO();
			  scriptVO.setScriptContent(script.get("A"));
			  scriptVO.setScriptSt(script.get("B"));
			  scriptVO.setScriptGbSq(scriptGbSq);
			
			  if(contentList.contains(script.get("A"))){
				  scriptMapper.createUpdate(scriptVO);
			  }else {
				  scriptMapper.create(scriptVO);
			  }
		  }
	}
	
	/**
	 * 스크립트 전체 리스트를 반환하는 메서드
	 * @return List<scriptVo>
	 * @throws Exception
	 */
	public List<ScriptVO> retrieveList() throws Exception{
		return scriptMapper.retrieveList();
	}
	
	/**
	 * 스크립트를 수정하는 메서드
	 * @param ScriptGbVO
	 * @return 성공 시 1, 실패 시 0
	 * @throws Exception
	 */
	public int update(ScriptVO ScriptVO) throws Exception{
		return scriptMapper.update(ScriptVO);
	}
	
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
	 * 검색한 스크립트 리스트를 반환하는 메서드
	 * @param keyword
	 * @return
	 * @throws Exception
	 */
	public List<ScriptVO> retrieveScriptSearchList(String keyword)  throws Exception{
		return scriptMapper.retrieveScriptSearchList(keyword);
	}
	
	/**
	 * 스크립트 구분 sq에 맞는 스크립트 전체리스트를 반환하는 메서드
	 * @return List<ScriptVo>
	 * @throws Exception
	 */
	public List<ScriptVO> retrieveSelectList(String scriptGbSq) throws Exception{
		return scriptMapper.retrieveSelectList(scriptGbSq);
	}

	/**
	 * 스크립트 구분 별 스크립트 목록을 조회하는 메서드
	 * @param retrieveMap
	 * @return
	 */
	public List<ScriptVO> retrieveScriptGbScriptPagingList(Map<String, Object> retrieveMap)  throws Exception{
		return scriptMapper.retrieveScriptGbScriptPagingList(retrieveMap);
	}

	/**
	 * 스크립트 구분 별 스크립트의 총 개수
	 * @param scriptVO
	 * @return 스크립트 구분별 스크립트의 총 개수
	 */
	public int retrieveScriptGbScriptPagingListCnt(ScriptVO scriptVO) throws Exception{
		return scriptMapper.retrieveScriptGbScriptPagingListCnt(scriptVO);
	}
	
//	/**
//	 * 페이징 처리 후 해당 페이지의 스크립트 리스트를 반환하는 메서드
//	 * @param scriptVO
//	 * @return
//	 */
//	public List<ScriptVO> retrievePagingList(ScriptVO scriptVO) throws Exception{
//		return scriptMapper.retrievePagingList(scriptVO);
//	}
//
//	/**
//	 * 페이징처리를 위한 스크립트의 총 개수를 구하는 메서드
//	 * @param scriptVO
//	 * @return 스크립트의 총 개수
//	 */
//	public int retrievePagingListCnt(ScriptVO scriptVO) throws Exception{
//		return scriptMapper.retrievePagingListCnt(scriptVO);
//	}
}
