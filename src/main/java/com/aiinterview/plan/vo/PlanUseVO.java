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
	private String startDay ; 
	private String endDay ;
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((endDate == null) ? 0 : endDate.hashCode());
		result = prime * result + ((endDay == null) ? 0 : endDay.hashCode());
		result = prime * result + ((memId == null) ? 0 : memId.hashCode());
		result = prime * result + ((planSq == null) ? 0 : planSq.hashCode());
		result = prime * result + ((sdf == null) ? 0 : sdf.hashCode());
		result = prime * result + ((startDate == null) ? 0 : startDate.hashCode());
		result = prime * result + ((startDay == null) ? 0 : startDay.hashCode());
		result = prime * result + term;
		result = prime * result + ((useSq == null) ? 0 : useSq.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PlanUseVO other = (PlanUseVO) obj;
		if (endDate == null) {
			if (other.endDate != null)
				return false;
		} else if (!endDate.equals(other.endDate))
			return false;
		if (endDay == null) {
			if (other.endDay != null)
				return false;
		} else if (!endDay.equals(other.endDay))
			return false;
		if (memId == null) {
			if (other.memId != null)
				return false;
		} else if (!memId.equals(other.memId))
			return false;
		if (planSq == null) {
			if (other.planSq != null)
				return false;
		} else if (!planSq.equals(other.planSq))
			return false;
		if (sdf == null) {
			if (other.sdf != null)
				return false;
		} else if (!sdf.equals(other.sdf))
			return false;
		if (startDate == null) {
			if (other.startDate != null)
				return false;
		} else if (!startDate.equals(other.startDate))
			return false;
		if (startDay == null) {
			if (other.startDay != null)
				return false;
		} else if (!startDay.equals(other.startDay))
			return false;
		if (term != other.term)
			return false;
		if (useSq == null) {
			if (other.useSq != null)
				return false;
		} else if (!useSq.equals(other.useSq))
			return false;
		return true;
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	
	public String getStartDay() {
		this.startDay = sdf.format(startDate);
		return startDay;
	}
	public String getEndDay() {
		this.endDay = sdf.format(endDate);
		return endDay;
	}
	
//	startList.add(sdf.format(resultList.get(i).getStartDate()));
//	endList.add(sdf.format(resultList.get(i).getEndDate()));
	
	
	public int getTerm() {
		return term;
	}
	public void setTerm(int term) {
		this.term = term;
	}
	
	
	
	
	@Override
	public String toString() {
		return "PlanUseVO [useSq=" + useSq + ", startDate=" + startDate + ", endDate=" + endDate + ", memId=" + memId
				+ ", planSq=" + planSq + ", term=" + term + ", startDay=" + startDay + ", endDay=" + endDay + ", sdf="
				+ sdf + "]";
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
