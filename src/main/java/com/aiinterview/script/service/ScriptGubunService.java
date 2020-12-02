package com.aiinterview.script.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.common.util.excel.option.ReadOption;
import com.aiinterview.common.util.excel.read.ExcelRead;
import com.aiinterview.interview.vo.QuestionGubunVO;
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
	
//	/**
//	 * 스크립트 구분을 일괄등록하는 메서드
//	 * @param destFile
//	 * @throws Exception 
//	 */
//	public void createMassiveQuestGb(File destFile) throws Exception {
//		ReadOption readOption = new ReadOption();
//		  readOption.setFilePath(destFile.getAbsolutePath());
//		  readOption.setOutputColumns("A","B","C");
//		  readOption.setStartRow(2);
//
//		  List<Map<String, String>> excelContent = ExcelRead.read(readOption);
//
//		  ScriptGubunVO scriptGbVO = null;
//		  for(Map<String, String> scriptGb : excelContent) {
//			  scriptGbVO = new ScriptGubunVO();
//			  scriptGbVO.setScriptGbContent(scriptGb.get("B"));
//			  scriptGbVO.setScriptGbSt(scriptGb.get("C"));
//			  
//			  scriptGubunMapper.create(scriptGbVO);
//		  }
//	}
	
//	/**
//	 * 스크립트 구분 검색 목록을 조회하는 메서드
//	 * @return questGbList
//	 * @throws Exception 
//	 */
//	public List<ScriptGubunVO> retrieveSearchList(String keyword) throws Exception {
//		System.out.println("스크립트 구분 검색  service keyword : "+keyword);
//		return scriptGubunMapper.retrieveSearchList(keyword);
//	}
}
