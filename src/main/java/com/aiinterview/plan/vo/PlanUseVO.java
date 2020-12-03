package com.aiinterview.plan.vo;

import java.util.Date;

public class PlanUseVO extends PlanVO{
	
	private String useSq;
	private Date startDate;
	private Date endDate;
	private String memId;
	private String planSq;
	private int term;
	
	public int getTerm() {
		return term;
	}
	public void setTerm(int term) {
		this.term = term;
	}
	@Override
	public String toString() {
		return "PlanUseVO [useSq=" + useSq + ", startDate=" + startDate + ", endDate=" + endDate + ", memId=" + memId
				+ ", planSq=" + planSq + "]";
	}
	public String getUseSq() {
		return useSq;
	}
	public void setUseSq(String useSq) {
		this.useSq = useSq;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getPlanSq() {
		return planSq;
	}
	public void setPlanSq(String planSq) {
		this.planSq = planSq;
	}
	
	
	
	
	
	
	
}
