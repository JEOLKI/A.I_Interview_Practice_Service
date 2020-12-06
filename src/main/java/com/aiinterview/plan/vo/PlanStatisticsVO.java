package com.aiinterview.plan.vo;

import com.aiinterview.base.vo.BaseVO;

public class PlanStatisticsVO  extends BaseVO{
	private int rn;			// 통계 출력 순서번호
	private String planNm;	// 이용권 이름
	private int useCount;	// 이용권 이용 횟수
	
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	public String getPlanNm() {
		return planNm;
	}
	public void setPlanNm(String planNm) {
		this.planNm = planNm;
	}
	public int getUseCount() {
		return useCount;
	}
	public void setUseCount(int useCount) {
		this.useCount = useCount;
	}
	
	
}
