package com.aiinterview.script.vo;

public class ScriptTestVO {
	private int scriptTestSq;		//스크립트 테스트의 고유번호
	private int scriptTestScore;	//테스트 결과 점수
	private String performScript;	//사용자의 테스트시 만들어진 음원파일에서 추출한 스크립트
	private String scriptTestDate;	//테스트 실시 날짜
	private String memId;			//테스트에 응시한 회원ID
	private int scriptSq;			//스크립트의 고유번호
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((memId == null) ? 0 : memId.hashCode());
		result = prime * result + ((performScript == null) ? 0 : performScript.hashCode());
		result = prime * result + scriptSq;
		result = prime * result + ((scriptTestDate == null) ? 0 : scriptTestDate.hashCode());
		result = prime * result + scriptTestScore;
		result = prime * result + scriptTestSq;
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
		ScriptTestVO other = (ScriptTestVO) obj;
		if (memId == null) {
			if (other.memId != null)
				return false;
		} else if (!memId.equals(other.memId))
			return false;
		if (performScript == null) {
			if (other.performScript != null)
				return false;
		} else if (!performScript.equals(other.performScript))
			return false;
		if (scriptSq != other.scriptSq)
			return false;
		if (scriptTestDate == null) {
			if (other.scriptTestDate != null)
				return false;
		} else if (!scriptTestDate.equals(other.scriptTestDate))
			return false;
		if (scriptTestScore != other.scriptTestScore)
			return false;
		if (scriptTestSq != other.scriptTestSq)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "ScriptTestVo [scriptTestSq=" + scriptTestSq + ", scriptTestScore=" + scriptTestScore
				+ ", performScript=" + performScript + ", scriptTestDate=" + scriptTestDate + ", memId=" + memId
				+ ", scriptSq=" + scriptSq + "]";
	}
}
