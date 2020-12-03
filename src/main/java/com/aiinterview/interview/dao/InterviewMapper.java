package com.aiinterview.interview.dao;

import java.util.List;

import com.aiinterview.interview.vo.InterviewVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("interviewMapper")
public interface InterviewMapper {
	
	/**
	 * 면접의 전체 목록을 조회하는 메서드
	 * @return interviewList
	 * @throws Exception
	 */
	public List<InterviewVO> retrieveList() throws Exception;
	
	/**
	 * 해당 페이지의 면접 목록을 조회하는 메서드
	 * @param interviewVO
	 * @return interviewList
	 * @throws Exception
	 */
	public List<InterviewVO> retrievePagingList(InterviewVO interviewVO) throws Exception;
	
	
	/**
	 * 페이징 처리를 위한 면접의 갯수를 구하는 메서드
	 * @param InterviewVO
	 * @return 해당 사용자의 면접 갯수
	 * @throws Exception
	 */
	public int retrievePagingListCnt(InterviewVO interviewVO) throws Exception;
	
	/**
	 * 해당하는 면접 번호의 면접 정보를 가져오는 메서드
	 * @param interviewSq 면접 번호
	 * @return interviewVO 객체
	 * @throws Exception
	 */
	public InterviewVO retrieve(String interviewSq) throws Exception;
	
	/**
	 * 새로운 면접을 등록하는 메서드
	 * @param interviewVO 등록할 면접의 정보를 담은 객체
	 * @throws Exception
	 */
	public void create(InterviewVO interviewVO) throws Exception;
	
	/**
	 * 면접의 정보를 수정하기 위한 메서드 
	 * @param interviewVO
	 * @return 수정 성공횟수 
	 * @throws Exception
	 */
	public int update(InterviewVO interviewVO) throws Exception;
	
	/**
	 * 면접을 삭제하기 위한 메서드
	 * @param interviewSq
	 * @return
	 * @throws Exception
	 */
	public int delete(String interviewSq) throws Exception;
	

	
}
