package com.aiinterview.interview.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.common.util.excel.option.ReadOption;
import com.aiinterview.common.util.excel.read.ExcelRead;
import com.aiinterview.interview.dao.QuestionGubunMapper;
import com.aiinterview.interview.vo.QuestionGubunVO;


@Service("questionGubunService")
public class QuestionGubunService {
	
	
	@Resource(name="questionGubunMapper")
	private QuestionGubunMapper questionGubunMapper;

	/**
	 * 샘플질문 구분(직무) 목록을 조회하는 메서드
	 * @return questGbList
	 * @throws Exception 
	 */
	public List<QuestionGubunVO> retrieveQuestGbList() throws Exception {
		System.out.println("질문 구분 리스트 조회 service");
		return questionGubunMapper.retrieveQuestGbList();
	}

	/**
	 * 샘플질문 구분(직무)를 등록하는 메서드
	 * @param questGbVO
	 * @throws Exception 
	 */
	public void create(QuestionGubunVO questGbVO) throws Exception {
		System.out.println("질문 구분 등록  service"); 
		questionGubunMapper.create(questGbVO);
		System.out.println("질문 구분 등록 service 후");
	}

	/**
	 * 샘플질문 구분(직무)를 일괄등록하는 메서드
	 * @param destFile
	 * @throws Exception 
	 */
	public void createMassiveQuestGb(File destFile) throws Exception {
		ReadOption readOption = new ReadOption();
		  readOption.setFilePath(destFile.getAbsolutePath());
		  readOption.setOutputColumns("A","B","C");
		  readOption.setStartRow(2);

		  List<Map<String, String>> excelContent = ExcelRead.read(readOption);

		  QuestionGubunVO questGbVO = null;
		  for(Map<String, String> questGb : excelContent) {
			  questGbVO = new QuestionGubunVO();
			  questGbVO.setQuestGbContent(questGb.get("B"));
			  questGbVO.setQuestGbSt(questGb.get("C"));
			  
			  questionGubunMapper.create(questGbVO);
		  }
		
	}

	/**
	 * 샘플질문 구분(직무)를 수정하는 메서드
	 * @param questGbVO
	 * @return
	 */
	public int update(QuestionGubunVO questGbVO) {
		System.out.println("질문 구분 수정  service");
		int updateCnt = questionGubunMapper.update(questGbVO);
		System.out.println("질문 구분 수정  service updateCnt : "+updateCnt);
		return updateCnt;
	}
	
	/**
	 * 샘플질문 구분(직무) 검색 목록을 조회하는 메서드
	 * @return questGbList
	 * @throws Exception 
	 */
	public List<QuestionGubunVO> retrieveQuestGbSearchList(String keyword) throws Exception {
		System.out.println("질문 구분 검색  service keyword : "+keyword);
		return questionGubunMapper.retrieveQuestGbSearchList(keyword);
	}


}
