package com.aiinterview.script.service;

import java.io.File;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.aiinterview.analysis.vo.ScriptGbAnalysisVO;
import com.aiinterview.common.util.excel.option.ReadOption;
import com.aiinterview.common.util.excel.read.ExcelRead;
import com.aiinterview.script.dao.ScriptGubunMapper;
import com.aiinterview.script.vo.ScriptGubunVO;

@Service("scriptGubunService")
public class ScriptGubunService {
	private static final Logger logger = LoggerFactory.getLogger(ScriptGubunService.class);
	
	@Resource(name = "scriptGubunMapper")
	private ScriptGubunMapper scriptGubunMapper;
	
	/**
	 * 페이징처리를 위한  해당페이지 스크립트 구분 리스트
	 * @param ScriptGbVO
	 * @return
	 * @throws Exception
	 */
	public List<ScriptGubunVO> retrievePagingList(ScriptGubunVO scriptGbVO) throws Exception {
		return scriptGubunMapper.retrievePagingList(scriptGbVO);
	}
	
	/**
	 * 페이징처리를 위한 스크립트 구분의 총 개수를 구하는 메서드
	 * @param ScriptGbVO
	 * @return 스크립트 구분 총 갯수
	 * @throws Exception
	 */
	public int retrievePagingListCnt(ScriptGubunVO scriptGbVO) throws Exception {
		return scriptGubunMapper.retrievePagingListCnt(scriptGbVO);
	}
	
	/**
	 * 스크립트 구분 한개를 등록하는 메서드
	 * @return
	 * @throws Exception
	 */
	public void create(ScriptGubunVO ScriptGbVO) throws Exception{
		scriptGubunMapper.create(ScriptGbVO);
	}
	
	/**
	 * 스크립트 구분을 일괄등록하는 메서드
	 * @param destFile
	 * @throws Exception
	 */
	public void createMassiveScriptGubun(File destFile) throws Exception {
		ReadOption readOption = new ReadOption();
		readOption.setFilePath(destFile.getAbsolutePath());
		readOption.setOutputColumns("A", "B"); 	//content, status
		readOption.setStartRow(2);
		
		List<Map<String, String>> excelContent = ExcelRead.read(readOption);
		
		ScriptGubunVO scriptGbVO = null;
		for(Map<String, String> scriptGb : excelContent) {
			scriptGbVO = new ScriptGubunVO();
			scriptGbVO.setScriptGbContent(scriptGb.get("A"));
			scriptGbVO.setScriptGbSt(scriptGb.get("B"));
			
			scriptGubunMapper.create(scriptGbVO);
		}
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
	 * 스크립트 구분의 상태를 수정하는 메서드
	 * @param ScriptGbVO
	 * @return 성공 시 1, 실패 시 0
	 * @throws Exception
	 */
	public int update(ScriptGubunVO ScriptGbVO) throws Exception{
		return scriptGubunMapper.update(ScriptGbVO);
	}
	
	
	/**
	 * 검색한 스크립트 구분 리스트를 반환하는 메서드
	 * @param keyword
	 * @return
	 * @throws Exception
	 */
	public List<ScriptGubunVO> retrieveScriptGubunSearchList(String keyword)  throws Exception{
		return scriptGubunMapper.retrieveScriptGubunSearchList(keyword);
	}
	
	/**
	 * 스크립트 구분 하나를 반환하는 메서드
	 * @param scriptGbSq
	 * @return ScriptGubunVO
	 * @throws Exception
	 */
	public ScriptGubunVO retrieve(String scriptGbSq) throws Exception{
		return scriptGubunMapper.retrieve(scriptGbSq);
	}

//	/**
//	 * 스크립트 구분 도출 횟수 리스트를 조회하는 메서드
//	 * 스크립트 구분 통계용
//	 * @param statisticMap
//	 * @return
//	 * @throws Exception
//	 */
//	public List<ScriptGbAnalysisVO> retrieveStatisticsPagingList(Map<String, Object> statisticMap) throws Exception{
//		return scriptGubunMapper.retrieveStatisticsPagingList(statisticMap);
//	}
//
//	/**
//	 * 페이징 후 스크립트 구분 도출 횟수
//	 * @param statisticMap
//	 * @return
//	 * @throws Exception
//	 */
//	public int retrieveStatisticsPagingListCnt(Map<String, Object> statisticMap) throws Exception {
//		return scriptGubunMapper.retrieveStatisticsPagingListCnt(statisticMap);
//	}
}
