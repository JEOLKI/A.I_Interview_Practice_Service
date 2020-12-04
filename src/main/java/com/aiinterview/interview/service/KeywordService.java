package com.aiinterview.interview.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.KeywordMapper;
import com.aiinterview.interview.dao.KeywordMatchingMapper;
import com.aiinterview.interview.dao.TalentMapper;
import com.aiinterview.interview.vo.KeywordMatchingVO;
import com.aiinterview.interview.vo.KeywordVO;

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
	 * @param retrieveMap
	 * @return
	 */
	public List<KeywordVO> retrieveTalentKeywordPagingList(Map<String, Object> retrieveMap) throws Exception{
		return keywordMapper.retrieveTalentKeywordPagingList(retrieveMap);
	}

////////////////////////////////////////// 이하 모델링 수정 이후/////////////////////////////////////////////
	
	/**
	 * 해당 내용의 키워드 존재여부를 조회하는 메서드
	 * @param keywordContent
	 * @return
	 */
	public int retrieve(String keywordContent) throws Exception{
		return keywordMapper.retrieve(keywordContent);
	}

	/**
	 * 해당 내용의 키워드를 생성하는 메서드
	 * @param keywordContent
	 * @return 
	 * @return 
	 * @return
	 */
	public void create(String keywordContent) throws Exception{
		System.out.println("서비스 keywordContent : "+ keywordContent);
		keywordMapper.create(keywordContent);
	}

	
	/**
	 * 해당내용의 키워드를 조회하는 메서드
	 * @param keywordContent
	 * @return
	 * @throws Exception 
	 */
	public int retrieveKeywordSq(String keywordContent) throws Exception {
		return keywordMapper.retrieveKeywordSq(keywordContent);
	}


	/**
	 * 인재상별 모든 키워드 리스트 조회하는 메서드 
	 * 다운로드용
	 * @param talentSq
	 * @return
	 */
	public List<KeywordVO> retrieveTalentKeywordAllList(String talentSq) {
		return keywordMapper.retrieveTalentKeywordAllList(talentSq);
	}
}
