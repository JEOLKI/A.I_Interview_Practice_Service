package com.aiinterview.plan.vo;

import java.text.DecimalFormat;

import com.aiinterview.base.vo.BaseVO;

public class PlanVO extends BaseVO{
	
	
	private String planSq          ;
	private String planNm          ;
	private int planPrice       ;
	private String planExplain     ;
	private String planSt          ;
	private String planPeriod      ;
	private String fmtPlanPrice;
	
	DecimalFormat format = new DecimalFormat("###,###");
	
	public String getFmtPlanPrice() {
		this.fmtPlanPrice = format.format(planPrice);
		return fmtPlanPrice;
	}

	public String getPlanSq() {
		return planSq;
	}

	public void setPlanSq(String planSq) {
		this.planSq = planSq;
	}

	public String getPlanNm() {
		return planNm;
	}

	public void setPlanNm(String planNm) {
		this.planNm = planNm;
	}

	public int getPlanPrice() {
		return planPrice;
	}

	public void setPlanPrice(int planPrice) {
		this.planPrice = planPrice;
	}

	public String getPlanExplain() {
		return planExplain;
	}

	public void setPlanExplain(String planExplain) {
		this.planExplain = planExplain;
	}

	public String getPlanSt() {
		return planSt;
	}

	public void setPlanSt(String planSt) {
		this.planSt = planSt;
	}

	public String getPlanPeriod() {
		return planPeriod;
	}

	public void setPlanPeriod(String planPeriod) {
		this.planPeriod = planPeriod;
	}

	public DecimalFormat getFormat() {
		return format;
	}

	public void setFormat(DecimalFormat format) {
		this.format = format;
	}

	@Override
	public String toString() {
		return "PlanVO [planSq=" + planSq + ", planNm=" + planNm + ", planPrice=" + planPrice + ", planExplain="
				+ planExplain + ", planSt=" + planSt + ", planPeriod=" + planPeriod + ", fmtPlanPrice=" + fmtPlanPrice
				+ ", format=" + format + "]";
	}


	
	
	
	
}