package com.aiinterview.interview.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.common.util.excel.option.ReadOption;
import com.aiinterview.common.util.excel.read.ExcelRead;
import com.aiinterview.interview.dao.HabitMapper;
import com.aiinterview.interview.vo.HabitVO;

@Service("habitService")
public class HabitService {
	
	@Resource(name="habitMapper")
	private HabitMapper habitMapper;

	/**
	 * 습관어를 등록하는 메서드
	 * @param habitVO
	 * @throws Exception
	 */
	public void create(HabitVO habitVO) throws Exception {
		habitMapper.create(habitVO);
	}

	/**
	 * 습관어 리스트를 조회하는 메서드
	 * 목록 출력용(엑셀)
	 * @return 습관어 목록
	 * @throws Exception 
	 */
	public List<HabitVO> retrieveList() throws Exception {
		return habitMapper.retrieveList();
	}
	
	/**
	 * 해당 번호의 습관어 내용을 조회하는 메서드
	 * 리포트 출력용
	 * @param habitSq
	 * @return
	 * @throws Exception
	 */
	public String retrieve(String habitSq) throws Exception{
		return habitMapper.retrieve(habitSq);
	}
	
	/**
	 * 사용중인 습관어 리스트를 조회하는 메서드
	 * 분석용
	 * @return 습관어 목록
	 * @throws Exception 
	 */
	public List<HabitVO> retrieveUsingList() throws Exception {
		return habitMapper.retrieveUsingList();
	}

	/**
	 * 습관어를 수정하는 메서드
	 * @param habitVO
	 * @return 1: 수정 성공 / 0: 수정 실패
	 * @throws Exception 
	 */
	public int update(HabitVO habitVO) throws Exception {
		int updateCnt = habitMapper.update(habitVO);
		return updateCnt;
		
	}

	/**
	 * 습관어를 일괄등록하는 메서드
	 * @param destFile
	 * @throws Exception 
	 */
	public void createMassiveHabit(File destFile) throws Exception {
		ReadOption readOption = new ReadOption();
		  readOption.setFilePath(destFile.getAbsolutePath());
		  readOption.setOutputColumns("A","B");
		  readOption.setStartRow(2);

		  List<Map<String, String>> excelContent = ExcelRead.read(readOption);

		  HabitVO habitVO = null;
		  for(Map<String, String> habit : excelContent) {
			  habitVO = new HabitVO();
			  habitVO.setHabitGb(habit.get("A"));
			  habitVO.setHabitSt(habit.get("B"));
			  
			  habitMapper.create(habitVO);
		  }
	}

	/**
	 * 페이징처리를 위한 해당페이지 목록 조회하는 메서드
	 * @param HabitVO
	 * @return 해당페이지 목록
	 * @throws Exception 
	 */
	public List<HabitVO> retrievePagingList(HabitVO habitVO) throws Exception {
		return habitMapper.retrievePagingList(habitVO);
	}

	/**
	 * 페이징처리를 위한 전체 habitVO 개수 구하는 메서드
	 * @param habitVO
	 * @return 전체 habitVO 개수
	 * @throws Exception 
	 */
	public int retrievePagingListCnt(HabitVO habitVO) throws Exception {
		return habitMapper.retrievePagingListCnt(habitVO);	}



}
