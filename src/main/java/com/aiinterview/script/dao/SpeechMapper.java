package com.aiinterview.script.dao;


import java.util.List;

import com.aiinterview.script.vo.SpeechVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("speechMapper")
public interface SpeechMapper {

	/**
	 * 스피치 테스트 결과 값을 입력하기 위한 메서드
	 * @param sv
	 * @return
	 */
	public int create(SpeechVO sv)throws Exception;
	
	/**
	 * 아이디와 일치하는 스피치의 결과값을 나타내기 위한 메서드 
	 * @param sv
	 * @return
	 */
	public List<SpeechVO> retrieve(SpeechVO sv)throws Exception;
}
