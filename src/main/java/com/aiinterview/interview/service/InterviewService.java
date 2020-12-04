package com.aiinterview.interview.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.InterviewMapper;
import com.aiinterview.interview.dao.QuestionMapper;
import com.aiinterview.interview.vo.InterviewVO;
import com.aiinterview.interview.vo.QuestionVO;

@Service("interviewService")
public class InterviewService {
	
	@Resource(name="interviewMapper")
	private InterviewMapper interviewMapper;
	
	@Resource(name="questionMapper")
	private QuestionMapper questionMapper;
	
	public List<InterviewVO> retrievePagingList(InterviewVO interviewVO) throws Exception {
		return interviewMapper.retrievePagingList(interviewVO);
	}
	
	public List<InterviewVO> retrieveList() throws Exception{
		return interviewMapper.retrieveList();
	}

	public int retrievePagingListCnt(InterviewVO interviewVO) throws Exception {
		return interviewMapper.retrievePagingListCnt(interviewVO);
	}
	
	public InterviewVO retrieve(String interviewSq) throws Exception{
		return interviewMapper.retrieve(interviewSq);
	}
	
	public String create(Map<String, Object> map) throws Exception{
		
		InterviewVO interviewVO = (InterviewVO) map.get("interviewVO");
		
		interviewMapper.create(interviewVO);
		String interviewSq = interviewVO.getInterviewSq();
		
		List<QuestionVO> questionVOList = (List<QuestionVO>) map.get("questionVOList");
		
		for(QuestionVO questionVO : questionVOList) {
			questionVO.setInterviewSq(interviewSq);
			questionMapper.create(questionVO);
		}
		
		return interviewSq;
	}
	
	public int update(InterviewVO interviewVO) throws Exception{
		return interviewMapper.update(interviewVO);
	}
	
	public int delete(String interviewSq) throws Exception{
		return interviewMapper.delete(interviewSq);
	}

}
