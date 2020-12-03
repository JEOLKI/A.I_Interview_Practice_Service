package com.aiinterview.interview.vo;

import com.aiinterview.base.vo.BaseVO;

public class InterviewVO extends BaseVO {

	private String interviewSq; // 면접 번호
	private String interviewNm = "이름없는 면접"; // 면접 이름
	private String interviewDate; // 면접 일자
	private String memId; // 회원 아이디

	public String getInterviewSq() {
		return interviewSq;
	}

	public void setInterviewSq(String interviewSq) {
		this.interviewSq = interviewSq;
	}

	public String getInterviewNm() {
		return interviewNm;
	}

	public void setInterviewNm(String interviewNm) {
		this.interviewNm = interviewNm;
	}

	public String getInterviewDate() {
		return interviewDate;
	}

	public void setInterviewDate(String interviewDate) {
		this.interviewDate = interviewDate;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

}
