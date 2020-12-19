package com.aiinterview.script.vo;

public class ScriptTestVO extends ScriptVO{
	private String scriptTestSq;	//스크립트 테스트 고유번호
	private String scriptTestScore;	//테스트 결과 점수
	private String performScript;	//사용자의 테스트 스크립트
	private String scriptTestDate;	//테스트 실시 날짜
	private String memId;			//테스트에 응시한 회원ID
	private String scriptSq;		//스크립트의 고유번호
	private String scriptGbSq;      //리스트뽑을떄 필요한 스크립트 구분번호
	
	public ScriptTestVO() {
		
	}
	
	public ScriptTestVO(String scriptTestScore, String performScript, String memId, String scriptSq) {
		this.scriptTestScore = scriptTestScore;
		this.performScript = performScript;
		this.memId = memId;
		this.scriptSq = scriptSq;
	}

	public String getScriptTestSq() {
		return scriptTestSq;
	}
	public void setScriptTestSq(String scriptTestSq) {
		this.scriptTestSq = scriptTestSq;
	}
	public String getScriptTestScore() {
		return scriptTestScore;
	}
	public void setScriptTestScore(String scriptTestScore) {
		this.scriptTestScore = scriptTestScore;
	}
	public String getPerformScript() {
		return performScript;
	}
	public void setPerformScript(String performScript) {
		this.performScript = performScript;
	}
	public String getScriptTestDate() {
		return scriptTestDate;
	}
	public void setScriptTestDate(String scriptTestDate) {
		this.scriptTestDate = scriptTestDate;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getScriptSq() {
		return scriptSq;
	}
	public void setScriptSq(String scriptSq) {
		this.scriptSq = scriptSq;
	}
	public String getScriptGbSq() {
		return scriptGbSq;
	}
	public void setScriptGbSq(String scriptGbSq) {
		this.scriptGbSq = scriptGbSq;
	}

	@Override
	public String toString() {
		return "ScriptTestVO [	scriptTestSq=" + scriptTestSq
							+ ", scriptTestScore=" + scriptTestScore
							+ ", performScript=" + performScript
							+ ", scriptTestDate=" + scriptTestDate
							+ ", memId=" + memId
							+ ", scriptSq=" + scriptSq
							//+ ", scriptContent=" + scriptContent
							//+ ", scriptSt=" + scriptSt
							+ ", scriptGbSq=" + scriptGbSq + "]";
	}
}
