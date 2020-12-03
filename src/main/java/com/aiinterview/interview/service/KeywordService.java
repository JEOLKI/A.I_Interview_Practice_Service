package com.aiinterview.interview.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.common.util.excel.option.ReadOption;
import com.aiinterview.common.util.excel.read.ExcelRead;
import com.aiinterview.interview.dao.KeywordMapper;
import com.aiinterview.interview.dao.KeywordMatchingMapper;
import com.aiinterview.interview.dao.TalentMapper;
import com.aiinterview.interview.vo.KeywordMatchingVO;
import com.aiinterview.interview.vo.KeywordVO;
import com.aiinterview.interview.vo.TalentVO;

@Service("keywordService")
public class KeywordService {
	
	@Resource(name="keywordMapper")
	private KeywordMapper keywordMapper;

	@Resource(name="talentMapper")
	private TalentMapper talentMapper;
	
	@Resource(name="keywordMatchingMapper")
	private KeywordMatchingMapper keywordMatchingMapper;

	/**
	 * 페이징처리를 위한  해당페이지 키워드 리스트 추출
	 * @param keywordVO
	 * @return
	 */
	public List<KeywordVO> retrievePagingList(KeywordVO keywordVO) {
		return keywordMapper.retrievePagingList(keywordVO);
	}


	/**
	 * 페이징처리를 위한 키워드 총 개수를 구하는 메서드
	 * @param keywordVO
	 * @return 샘플질문 총 개수
	 */
	public int retrievePagingListCnt(KeywordVO keywordVO) {
		return keywordMapper.retrievePagingListCnt(keywordVO);
	}


	/**
	 * 키워드를 등록하는 메서드
	 * @param keywordVO
	 */
	public String create(KeywordVO keywordVO, String talentSq) {
		
		String KeywordSq = keywordMapper.create(keywordVO);
		
		KeywordMatchingVO keywordMatchingVO = new KeywordMatchingVO();
		keywordMatchingVO.setKeywordSq(KeywordSq);
		keywordMatchingVO.setTalentSq(talentSq);
		
		String keywordMatchingSq = keywordMatchingMapper.create(keywordMatchingVO);
		
		if(KeywordSq.equals(keywordMatchingSq)) {
			return  KeywordSq;
		}
		else {
			return "";
		}
	}
	
	/**
	 * 키워드를 일괄등록하는 메서드
	 * @param destFile
	 * @throws Exception 
	 */
	public void createMassiveKyeword(File destFile) throws Exception {
		ReadOption readOption = new ReadOption();
		  readOption.setFilePath(destFile.getAbsolutePath());
		  readOption.setOutputColumns("A","B","C");
		  readOption.setStartRow(2);
		  
		  List<TalentVO> talentUsingList = talentMapper.retrieveUsingList();
		  
		  List<Map<String, String>> excelContent = ExcelRead.read(readOption);

		  KeywordVO keywordVO = null;
		  KeywordMatchingVO keywordMatchingVO = null;
		  for(Map<String, String> keyword : excelContent) {
			  keywordVO = new KeywordVO();
			  keywordVO.setKeywordContent(keyword.get("B"));
			  keywordVO.setKeywordSt(keyword.get("C"));
			  
			  String keywordSq = keywordMapper.create(keywordVO);
			  
			  /* 키워드 매칭 테이블 insert */
			  keywordMatchingVO = new KeywordMatchingVO();
			  keywordMatchingVO.setKeywordSq(keywordSq);
			  for(int i=0; i < talentUsingList.size(); i++) {
				  if(keyword.get("A").equals(talentUsingList.get(i).getTalentNm())) {
					  keywordMatchingVO.setTalentSq(talentUsingList.get(i).getTalentSq());
				  }
			  }
			  keywordMatchingMapper.create(keywordMatchingVO);
		  }
		  
		
	}

	
	/**
	 * 키워드 목록을 조회하는 메서드
	 * @return keywordList
	 * @throws Exception 
	 */
	public List<KeywordVO> retrieveList() throws Exception {
		return keywordMapper.retrieveList();
	}

	/**
	 * 키워드를 수정하는 메서드
	 * @param keywordVO
	 * @return
	 */
	public int update(KeywordVO keywordVO, String talentSq) throws Exception {
		
		int kwdUpdateCnt = keywordMapper.update(keywordVO);
		
		KeywordMatchingVO keywordMatchingVO = new KeywordMatchingVO();
		keywordMatchingVO.setKeywordSq(keywordVO.getKeywordSq());
		keywordMatchingVO.setTalentSq(talentSq);
		
		int kwdMchUpdateCnt = keywordMatchingMapper.update(keywordMatchingVO);
		
		return kwdUpdateCnt + kwdMchUpdateCnt;
	}

	/**
	 * 인재상별 키워드 목록을 조회하는 메서드
	 * @param talentSq
	 * @return
	 */
	public List<KeywordVO> retrieveTalentKeywordList(String talentSq) throws Exception{
		return keywordMapper.retrieveTalentKeywordList(talentSq);
	}
}
