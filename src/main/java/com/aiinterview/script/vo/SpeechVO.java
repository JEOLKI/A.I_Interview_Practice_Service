package com.aiinterview.script.vo;

public class SpeechVO {
	private String speechtestSq    ;
	private String memId           ;
	private String speechTestScore ;
	private String speechScript    ;
	private String speechTestDate ;
	
	@Override
	public String toString() {
		return "SpeechVO [speechtestSq=" + speechtestSq + ", memId=" + memId + ", speechTestScore=" + speechTestScore
				+ ", speechScript=" + speechScript + ", speechTestDateA=" + speechTestDate + "]";
	}

	public String getSpeechtestSq() {
		return speechtestSq;
	}

	public void setSpeechtestSq(String speechtestSq) {
		this.speechtestSq = speechtestSq;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getSpeechTestScore() {
		return speechTestScore;
	}

	public void setSpeechTestScore(String speechTestScore) {
		this.speechTestScore = speechTestScore;
	}

	public String getSpeechScript() {
		return speechScript;
	}

	public void setSpeechScript(String speechScript) {
		this.speechScript = speechScript;
	}

	public String getSpeechTestDate() {
		return speechTestDate;
	}

	public void setSpeechTestDate(String speechTestDate) {
		this.speechTestDate = speechTestDate;
	}
	
	
	
}
