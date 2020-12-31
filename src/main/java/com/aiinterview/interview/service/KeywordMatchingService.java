package com.aiinterview.interview.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.KeywordMatchingMapper;
import com.aiinterview.interview.vo.KeywordMatchingVO;


@Service("keywordMatchingService")
public class KeywordMatchingService {
	
	@Resource(name="keywordMatchingMapper")
	private KeywordMatchingMapper keywordMatchingMapper;
	
	/**
	 * 해당 인재상에 해당하는 키워드를 삭제하는 메서드
	 * @param keywordMatchingVO
	 * @return 1: 성공/ 0: 실패
	 */
	public int delete(KeywordMatchingVO keywordMatchingVO) throws Exception{
		return keywordMatchingMapper.delete(keywordMatchingVO);
	}

	/**
	 * 키워드를 인재상에 매칭하는 메서드
	 * @param keywordMatchingVO
	 * @return
	 */
	public String create(KeywordMatchingVO keywordMatchingVO) throws Exception {
		return keywordMatchingMapper.create(keywordMatchingVO);
	}

	/**
	 * 해당 매칭을 조회하는 메서드
	 * @param keywordMatchingVO
	 * @return
	 */
	public int retrieve(KeywordMatchingVO keywordMatchingVO) throws Exception{
		return keywordMatchingMapper.retrieve(keywordMatchingVO);
	}

	/**
	 * 키워드 매칭 리스트를 조회하는 메서드
	 * @return
	 */
	public List<KeywordMatchingVO> retrieveList() throws Exception{
		return keywordMatchingMapper.retrieveList();
	}

	/**
	 * 키워드 매칭VO 한개를 조회하는 메서드
	 * @param keywordMatchingVO
	 * @return
	 */
	public KeywordMatchingVO retrieveOne(KeywordMatchingVO keywordMatchingVO) {
		return keywordMatchingMapper.retrieveOne(keywordMatchingVO);
	}

	/**
	 * 이미 등록되어있는 키워드 매칭을 다시 등록하려 할 때 update로 대체할 메서드
	 * @param keywordMatchingVO
	 */
	public int createUpdate(KeywordMatchingVO keywordMatchingVO) {
		return keywordMatchingMapper.createUpdate(keywordMatchingVO);
	}

	
}
