package com.aiinterview.member.vo;

import com.aiinterview.base.vo.BaseVO;

public class MemberVO extends BaseVO {

	private String memId;
	private String memPw;
	private String memAuth;
	private String memSt;
	private String memAlias;
	private String memNm;
	private String memTel;
	private String memAddr1;
	private String memAddr2;
	private int memZipcode;
	private String memCareer;
	private String memEduc;
	private String memGender;
	private String memTargetCompany;
	private String memTargetJob;
	private String searchJobDate;
	private String memMajor;
	private String memProfileNm;
	private String memProfilePath;
	
	private String count; // 그룹별 이용자 수를 세는 필드
	
	private String[] memIds; // 멤버 아이디를 받기위한 배열
	private String[] memAuths; // 멤버 권한을 받기위한 배열
	
	
	
	public String[] getMemIds() {
		return memIds;
	}

	public void setMemIds(String[] memIds) {
		this.memIds = memIds;
	}

	public String[] getMemAuths() {
		return memAuths;
	}

	public void setMemAuths(String[] memAuths) {
		this.memAuths = memAuths;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public MemberVO() {
		
	}

	public MemberVO(String memId, String memPw, String memAuth, String memSt, String memAlias, String memNm,
			String memTel, String memAddr1, String memAddr2, int memZipcode, String memCareer, String memEduc,
			String memGender, String memTargetCompany, String memTargetJob, String searchJobDate, String memMajor,
			String memProfileNm, String memProfilePath) {
		this.memId = memId;
		this.memPw = memPw;
		this.memAuth = memAuth;
		this.memSt = memSt;
		this.memAlias = memAlias;
		this.memNm = memNm;
		this.memTel = memTel;
		this.memAddr1 = memAddr1;
		this.memAddr2 = memAddr2;
		this.memZipcode = memZipcode;
		this.memCareer = memCareer;
		this.memEduc = memEduc;
		this.memGender = memGender;
		this.memTargetCompany = memTargetCompany;
		this.memTargetJob = memTargetJob;
		this.searchJobDate = searchJobDate;
		this.memMajor = memMajor;
		this.memProfileNm = memProfileNm;
		this.memProfilePath = memProfilePath;
	}

	public String getMemProfileNm() {
		return memProfileNm;
	}

	public void setMemProfileNm(String memProfileNm) {
		this.memProfileNm = memProfileNm;
	}

	public String getMemProfilePath() {
		return memProfilePath;
	}

	public void setMemProfilePath(String memProfilePath) {
		this.memProfilePath = memProfilePath;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemPw() {
		return memPw;
	}

	public void setMemPw(String memPw) {
		this.memPw = memPw;
	}

	public String getMemAuth() {
		return memAuth;
	}

	public void setMemAuth(String memAuth) {
		this.memAuth = memAuth;
	}

	public String getMemSt() {
		return memSt;
	}

	public void setMemSt(String memSt) {
		this.memSt = memSt;
	}

	public String getMemAlias() {
		return memAlias;
	}

	public void setMemAlias(String memAlias) {
		this.memAlias = memAlias;
	}

	public String getMemNm() {
		return memNm;
	}

	public void setMemNm(String memNm) {
		this.memNm = memNm;
	}

	public String getMemTel() {
		return memTel;
	}

	public void setMemTel(String memTel) {
		this.memTel = memTel;
	}

	public String getMemAddr1() {
		return memAddr1;
	}

	public void setMemAddr1(String memAddr1) {
		this.memAddr1 = memAddr1;
	}

	public String getMemAddr2() {
		return memAddr2;
	}

	public void setMemAddr2(String memAddr2) {
		this.memAddr2 = memAddr2;
	}

	public int getMemZipcode() {
		return memZipcode;
	}

	public void setMemZipcode(int memZipcode) {
		this.memZipcode = memZipcode;
	}

	public String getMemCareer() {
		return memCareer;
	}

	public void setMemCareer(String memCareer) {
		this.memCareer = memCareer;
	}

	public String getMemEduc() {
		return memEduc;
	}

	public void setMemEduc(String memEduc) {
		this.memEduc = memEduc;
	}

	public String getMemGender() {
		return memGender;
	}

	public void setMemGender(String memGender) {
		this.memGender = memGender;
	}

	public String getMemTargetCompany() {
		return memTargetCompany;
	}

	public void setMemTargetCompany(String memTargetCompany) {
		this.memTargetCompany = memTargetCompany;
	}

	public String getMemTargetJob() {
		return memTargetJob;
	}

	public void setMemTargetJob(String memTargetJob) {
		this.memTargetJob = memTargetJob;
	}

	public String getSearchJobDate() {
		return searchJobDate;
	}

	public void setSearchJobDate(String searchJobDate) {
		this.searchJobDate = searchJobDate;
	}

	public String getMemMajor() {
		return memMajor;
	}

	public void setMemMajor(String memMajor) {
		this.memMajor = memMajor;
	}


	@Override
	public String toString() {
		return "MemberVO [memId=" + memId + ", memPw=" + memPw + ", memAuth=" + memAuth + ", memSt=" + memSt
				+ ", memAlias=" + memAlias + ", memNm=" + memNm + ", memTel=" + memTel + ", memAddr1=" + memAddr1
				+ ", memAddr2=" + memAddr2 + ", memZipcode=" + memZipcode + ", memCareer=" + memCareer + ", memEduc="
				+ memEduc + ", memGender=" + memGender + ", memTargetCompany=" + memTargetCompany + ", memTargetJob="
				+ memTargetJob + ", searchJobDate=" + searchJobDate + ", memMajor=" + memMajor + ", memProfileNm="
				+ memProfileNm + ", memProfilePath=" + memProfilePath + ", count=" + count + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((memAddr1 == null) ? 0 : memAddr1.hashCode());
		result = prime * result + ((memAddr2 == null) ? 0 : memAddr2.hashCode());
		result = prime * result + ((memAlias == null) ? 0 : memAlias.hashCode());
		result = prime * result + ((memAuth == null) ? 0 : memAuth.hashCode());
		result = prime * result + ((memCareer == null) ? 0 : memCareer.hashCode());
		result = prime * result + ((memEduc == null) ? 0 : memEduc.hashCode());
		result = prime * result + ((memGender == null) ? 0 : memGender.hashCode());
		result = prime * result + ((memId == null) ? 0 : memId.hashCode());
		result = prime * result + ((memMajor == null) ? 0 : memMajor.hashCode());
		result = prime * result + ((memNm == null) ? 0 : memNm.hashCode());
		result = prime * result + ((memProfileNm == null) ? 0 : memProfileNm.hashCode());
		result = prime * result + ((memProfilePath == null) ? 0 : memProfilePath.hashCode());
		result = prime * result + ((memPw == null) ? 0 : memPw.hashCode());
		result = prime * result + ((memSt == null) ? 0 : memSt.hashCode());
		result = prime * result + ((memTargetCompany == null) ? 0 : memTargetCompany.hashCode());
		result = prime * result + ((memTargetJob == null) ? 0 : memTargetJob.hashCode());
		result = prime * result + ((memTel == null) ? 0 : memTel.hashCode());
		result = prime * result + memZipcode;
		result = prime * result + ((searchJobDate == null) ? 0 : searchJobDate.hashCode());
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
		MemberVO other = (MemberVO) obj;
		if (memAddr1 == null) {
			if (other.memAddr1 != null)
				return false;
		} else if (!memAddr1.equals(other.memAddr1))
			return false;
		if (memAddr2 == null) {
			if (other.memAddr2 != null)
				return false;
		} else if (!memAddr2.equals(other.memAddr2))
			return false;
		if (memAlias == null) {
			if (other.memAlias != null)
				return false;
		} else if (!memAlias.equals(other.memAlias))
			return false;
		if (memAuth == null) {
			if (other.memAuth != null)
				return false;
		} else if (!memAuth.equals(other.memAuth))
			return false;
		if (memCareer == null) {
			if (other.memCareer != null)
				return false;
		} else if (!memCareer.equals(other.memCareer))
			return false;
		if (memEduc == null) {
			if (other.memEduc != null)
				return false;
		} else if (!memEduc.equals(other.memEduc))
			return false;
		if (memGender == null) {
			if (other.memGender != null)
				return false;
		} else if (!memGender.equals(other.memGender))
			return false;
		if (memId == null) {
			if (other.memId != null)
				return false;
		} else if (!memId.equals(other.memId))
			return false;
		if (memMajor == null) {
			if (other.memMajor != null)
				return false;
		} else if (!memMajor.equals(other.memMajor))
			return false;
		if (memNm == null) {
			if (other.memNm != null)
				return false;
		} else if (!memNm.equals(other.memNm))
			return false;
		if (memProfileNm == null) {
			if (other.memProfileNm != null)
				return false;
		} else if (!memProfileNm.equals(other.memProfileNm))
			return false;
		if (memProfilePath == null) {
			if (other.memProfilePath != null)
				return false;
		} else if (!memProfilePath.equals(other.memProfilePath))
			return false;
		if (memPw == null) {
			if (other.memPw != null)
				return false;
		} else if (!memPw.equals(other.memPw))
			return false;
		if (memSt == null) {
			if (other.memSt != null)
				return false;
		} else if (!memSt.equals(other.memSt))
			return false;
		if (memTargetCompany == null) {
			if (other.memTargetCompany != null)
				return false;
		} else if (!memTargetCompany.equals(other.memTargetCompany))
			return false;
		if (memTargetJob == null) {
			if (other.memTargetJob != null)
				return false;
		} else if (!memTargetJob.equals(other.memTargetJob))
			return false;
		if (memTel == null) {
			if (other.memTel != null)
				return false;
		} else if (!memTel.equals(other.memTel))
			return false;
		if (memZipcode != other.memZipcode)
			return false;
		if (searchJobDate == null) {
			if (other.searchJobDate != null)
				return false;
		} else if (!searchJobDate.equals(other.searchJobDate))
			return false;
		return true;
	}

}