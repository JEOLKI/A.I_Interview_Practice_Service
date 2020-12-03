package com.aiinterview.interview.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.QuestionMapper;
import com.aiinterview.interview.vo.QuestionVO;

@Service("questionService")
public class QuestionService {
	
	@Resource(name="questionMapper")
	private QuestionMapper questionMapper;
	
	public List<QuestionVO> retrieveList(String interviewSq) throws Exception{
		return questionMapper.retrieveList(interviewSq);
	}
	
	public List<QuestionVO> retrievePagingList(QuestionVO questionVO) throws Exception {
		return questionMapper.retrievePagingList(questionVO);
	}
	
	public int retrievePagingListCnt(QuestionVO questionVO) throws Exception {
		return questionMapper.retrievePagingListCnt(questionVO);
	}
	
}
