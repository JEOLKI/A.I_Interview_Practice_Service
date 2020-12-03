package com.aiinterview.interview.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.common.util.excel.option.ReadOption;
import com.aiinterview.common.util.excel.read.ExcelRead;
import com.aiinterview.interview.dao.TalentMapper;
import com.aiinterview.interview.vo.TalentVO;


@Service("talentService")
public class TalentService{

	@Resource(name="talentMapper")
	private TalentMapper talentMapper;
	
	/**
	 * 페이징처리를 위한 해당페이지 목록 조회하는 메서드
	 * @param TalentVO
	 * @return 해당페이지 목록
	 */
	public List<TalentVO> retrievePagingList(TalentVO talentVO) {
		return talentMapper.retrievePagingList(talentVO);
	}

	/**
	 * 페이징처리를 위한 전체 talentVO 개수 구하는 메서드
	 * @param TalentVO
	 * @return 전체 talentVO 개수
	 */
	public int retrievePagingListCnt(TalentVO talentVO) {
		return talentMapper.retrievePagingListCnt(talentVO);	}
	
	
	/**
	 * 인재상을 등록하는 메서드
	 * @param talentVO
	 * @throws Exception
	 */
	public void create(TalentVO talentVO) throws Exception {
		talentMapper.create(talentVO);
	}

	/**
	 * 인재상 리스트를 조회하는 메서드
	 * @return 인재상 목록
	 */
	public List<TalentVO> retrieveList() {
		return talentMapper.retrieveList();
	}

	/**
	 * 인재상을 수정하는 메서드
	 * @param talentVO
	 * @return 1: 수정 성공 / 0: 수정 실패
	 */
	public int update(TalentVO talentVO) {
		int updateCnt = talentMapper.update(talentVO);
		return updateCnt;
		
	}

	/**
	 * 인재상을 일괄등록하는 메서드
	 * @param destFile
	 * @throws Exception 
	 */
	public void createMassiveTalent(File destFile) throws Exception {
		ReadOption readOption = new ReadOption();
		  readOption.setFilePath(destFile.getAbsolutePath());
		  readOption.setOutputColumns("A","B");
		  readOption.setStartRow(2);

		  List<Map<String, String>> excelContent = ExcelRead.read(readOption);

		  TalentVO talentVO = null;
		  for(Map<String, String> talent : excelContent) {
			  talentVO = new TalentVO();
			  talentVO.setTalentNm(talent.get("A"));
			  talentVO.setTalentSt(talent.get("B"));
			  
			  talentMapper.create(talentVO);
		  }
	}

	


}
