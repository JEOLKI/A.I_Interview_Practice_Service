package com.aiinterview.plan.vo;

import java.text.DecimalFormat;

public class PlanVO {
	
	
	private int planSq          ;
	private String planNm          ;
	private int planPrice       ;
	private String planExplain     ;
	private String planSt          ;
	private int planPeriod      ;
	private String fmtPlanPrice;
	
	DecimalFormat format = new DecimalFormat("###,###");
	
	public String getFmtPlanPrice() {
		this.fmtPlanPrice = format.format(planPrice);
		return fmtPlanPrice;
	}

	@Override
	public String toString() {
		return "PlanVo [planSq=" + planSq + ", planNm=" + planNm + ", planPrice=" + planPrice + ", planExplain="
				+ planExplain + ", planSt=" + planSt + ", planPeriod=" + planPeriod + ", fmtPlanPrice=" + fmtPlanPrice
				+ ", format=" + format + "]";
	}
	
	public int getPlanSq() {
		return planSq;
	}
	public void setPlanSq(int planSq) {
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
	public int getPlanPeriod() {
		return planPeriod;
	}
	public void setPlanPeriod(int planPeriod) {
		this.planPeriod = planPeriod;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((planExplain == null) ? 0 : planExplain.hashCode());
		result = prime * result + ((planNm == null) ? 0 : planNm.hashCode());
		result = prime * result + planPeriod;
		result = prime * result + planPrice;
		result = prime * result + planSq;
		result = prime * result + ((planSt == null) ? 0 : planSt.hashCode());
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
		PlanVO other = (PlanVO) obj;
		if (planExplain == null) {
			if (other.planExplain != null)
				return false;
		} else if (!planExplain.equals(other.planExplain))
			return false;
		if (planNm == null) {
			if (other.planNm != null)
				return false;
		} else if (!planNm.equals(other.planNm))
			return false;
		if (planPeriod != other.planPeriod)
			return false;
		if (planPrice != other.planPrice)
			return false;
		if (planSq != other.planSq)
			return false;
		if (planSt == null) {
			if (other.planSt != null)
				return false;
		} else if (!planSt.equals(other.planSt))
			return false;
		return true;
	}
	
	
	
}