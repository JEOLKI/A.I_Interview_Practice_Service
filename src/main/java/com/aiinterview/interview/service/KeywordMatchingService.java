package com.aiinterview.interview.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.KeywordMatchingMapper;


@Service("keywordMatchingService")
public class KeywordMatchingService {
	
	@Resource(name="keywordMatchingMapper")
	private KeywordMatchingMapper keywordMatchingMapper;
	
	/**
	 * 해당 인재상에 해당하는 키워드를 삭제하는 메서드
	 * @param deleteMap
	 * @return 1: 성공/ 0: 실패
	 */
	public int delete(Map<String, String> deleteMap) throws Exception{
		return keywordMatchingMapper.delete(deleteMap);
	}

}
