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
	 * 인재상별 키워드 목록을 조회하는 메서드
	 * @param retrieveMap
	 * @return
	 */
	public List<KeywordVO> retrieveTalentKeywordPagingList(Map<String, Object> retrieveMap) throws Exception{
		return keywordMapper.retrieveTalentKeywordPagingList(retrieveMap);
	}
	
	/**
	 * 해당 인재상번호의 모든 키워드 수를 조회하는 메서드 
	 * 다운로드용
	 * @param talentSq
	 * @return
	 */
	public int retrieveTalentKeywordPagingListCnt(Map<String, Object> retrieveMap) throws Exception{
		return keywordMapper.retrieveTalentKeywordPagingListCnt(retrieveMap);
	}

	
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
		keywordMapper.create(keywordContent);
	}

	
	/**
	 * 해당내용의 키워드번호를 조회하는 메서드
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
	public List<KeywordVO> retrieveTalentKeywordAllList(String talentSq) throws Exception{
		return keywordMapper.retrieveTalentKeywordAllList(talentSq);
	}


	/**
	 * 키워드 번호에 해당하는 키워드 내용 리스트 조회하는 메서드 
	 * 인재상 분석용
	 * @param talentSq
	 * @return
	 */
	public String retrieveKeywordContent(String keywordSq)throws Exception {
		return keywordMapper.retrieveKeywordContent(keywordSq);
	}

	
	
	
}
