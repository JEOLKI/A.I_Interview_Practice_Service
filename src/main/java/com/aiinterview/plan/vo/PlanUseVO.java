package com.aiinterview.plan.vo;

import java.util.Date;

public class PlanUseVO extends PlanVO{
	
	private int useSq;
	private Date startDate;
	private Date endDate;
	private String memId;
	private int planSq;
	
	public int getUseSq() {
		return useSq;
	}
	public void setUseSq(int useSq) {
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
	public int getPlanSq() {
		return planSq;
	}
	public void setPlanSq(int planSq) {
		this.planSq = planSq;
	}
	@Override
	public String toString() {
		return "PlanUseVo [useSq=" + useSq + ", startDate=" + startDate + ", endDate=" + endDate + ", memId=" + memId
				+ ", planSq=" + planSq + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((endDate == null) ? 0 : endDate.hashCode());
		result = prime * result + ((memId == null) ? 0 : memId.hashCode());
		result = prime * result + planSq;
		result = prime * result + ((startDate == null) ? 0 : startDate.hashCode());
		result = prime * result + useSq;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!super.equals(obj))
			return false;
		if (getClass() != obj.getClass())
			return false;
		PlanUseVO other = (PlanUseVO) obj;
		if (endDate == null) {
			if (other.endDate != null)
				return false;
		} else if (!endDate.equals(other.endDate))
			return false;
		if (memId == null) {
			if (other.memId != null)
				return false;
		} else if (!memId.equals(other.memId))
			return false;
		if (planSq != other.planSq)
			return false;
		if (startDate == null) {
			if (other.startDate != null)
				return false;
		} else if (!startDate.equals(other.startDate))
			return false;
		if (useSq != other.useSq)
			return false;
		return true;
	}
	
	
	
	
	
}
