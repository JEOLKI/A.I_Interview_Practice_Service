package com.aiinterview.plan.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class PlanUseVO extends PlanVO{
	
	private String useSq;
	private Date startDate;
	private Date endDate;
	private String memId;
	private String planSq;
	private int term;
	private String startDay ="0" ; 
	private String endDay = "0" ;
	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");

	public String getStartDay() {
		if(startDate!=null) {
			this.startDay = sdf.format(startDate);
			return startDay;
		}else {
			return null;
		}
	}
	
	public String getEndDay() {
		if(endDate!=null) {
			this.endDay = sdf.format(endDate);
			return endDay;
		}else {
			return null;
		}
	}
	
	public int getTerm() {
		return term;
	}
	public void setTerm(int term) {
		this.term = term;
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
