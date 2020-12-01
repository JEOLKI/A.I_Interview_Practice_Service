package com.aiinterview.script.vo;

public class ScriptGubunVO {
	private String scriptGbSq; 		//스크립트 구분 언어의 고유번호
	private String scriptGbContent; //스크립트 구분 언어
	private String scriptGbSt;		//스크립트 언어의 활성화 여부
	
	public ScriptGubunVO() {
		
	}
	
	public ScriptGubunVO(String scriptGbContent, String scriptGbSt) {
		this.scriptGbContent = scriptGbContent;
		this.scriptGbSt = scriptGbSt;
	}
	public String getScriptGbSq() {
		return scriptGbSq;
	}
	public void setScriptGbSq(String scriptGbSq) {
		this.scriptGbSq = scriptGbSq;
	}
	public String getScriptGbContent() {
		return scriptGbContent;
	}
	public void setScriptGbContent(String scriptGbContent) {
		this.scriptGbContent = scriptGbContent;
	}
	public String getScriptGbSt() {
		return scriptGbSt;
	}
	public void setScriptGbSt(String scriptGbSt) {
		this.scriptGbSt = scriptGbSt;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((scriptGbContent == null) ? 0 : scriptGbContent.hashCode());
		result = prime * result + ((scriptGbSq == null) ? 0 : scriptGbSq.hashCode());
		result = prime * result + ((scriptGbSt == null) ? 0 : scriptGbSt.hashCode());
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
		ScriptGubunVO other = (ScriptGubunVO) obj;
		if (scriptGbContent == null) {
			if (other.scriptGbContent != null)
				return false;
		} else if (!scriptGbContent.equals(other.scriptGbContent))
			return false;
		if (scriptGbSq == null) {
			if (other.scriptGbSq != null)
				return false;
		} else if (!scriptGbSq.equals(other.scriptGbSq))
			return false;
		if (scriptGbSt == null) {
			if (other.scriptGbSt != null)
				return false;
		} else if (!scriptGbSt.equals(other.scriptGbSt))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "ScriptGubunVO [scriptGbSq=" + scriptGbSq + ", scriptGbContent=" + scriptGbContent + ", scriptGbSt="
				+ scriptGbSt + "]";
	}

	
}

