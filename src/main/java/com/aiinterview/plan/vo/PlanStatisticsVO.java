package com.aiinterview.plan.vo;

import com.aiinterview.base.vo.BaseVO;

public class PlanStatisticsVO  extends BaseVO{
	private int rn;			// 통계 출력 순서번호
	private String planNm;	// 이용권 이름
	private int useCount;	// 이용권 이용 횟수
	private int sale;		// 이용권 매출
	private int planPrice;	// 이용권 금액
	
	public int getRn() {
		return rn;
	}
	public int getSale() {
		return sale;
	}
	public void setSale(int sale) {
		this.sale = sale;
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
	public int getPlanPrice() {
		return planPrice;
	}
	public void setPlanPrice(int planPrice) {
		this.planPrice = planPrice;
	}
	
	
}
