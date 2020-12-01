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
		System.out.println("습관어 등록  service"); 
		habitMapper.create(habitVO);
		System.out.println("습관어 등록 service 후");
	}

	/**
	 * 습관어 리스트를 조회하는 메서드
	 * @return 습관어 목록
	 */
	public List<HabitVO> retrieveHabitList() {
		System.out.println("습관어 리스트 조회 service");
		return habitMapper.retrieveHabitList();
	}

	/**
	 * 습관어를 수정하는 메서드
	 * @param habitVO
	 * @return 1: 수정 성공 / 0: 수정 실패
	 */
	public int update(HabitVO habitVO) {
		System.out.println("습관어 수정  service");
		int updateCnt = habitMapper.update(habitVO);
		System.out.println("습관어 수정  service updateCnt : "+updateCnt);
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



}
