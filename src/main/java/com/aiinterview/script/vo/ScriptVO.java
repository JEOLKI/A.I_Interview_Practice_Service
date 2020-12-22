package com.aiinterview.script.vo;

public class ScriptVO extends ScriptGubunVO{
	
	private String scriptSq; 		//스크립트 고유 번호
	private String scriptContent;	//스크립트 내용
	private String scriptSt;		//스크립트의 활성화, 비활성화 여부
	private String scriptGbSq; 		//스크립트구분(언어)의 고유 번호
	
	private String[] scriptSqs; 		//스크립트 고유 번호를 받기 위한 배열
	private String[] scriptContents;	//스크립트 내용를 받기 위한 배열
	private String[] scriptSts;		//스크립트의 활성화, 비활성화 여부를 받기 위한 배열
	private String[] scriptGbSqs; 		//스크립트구분(언어)의 고유 번호를 받기 위한 배열

	public ScriptVO() {
		
	}

	public ScriptVO(String scriptContent, String scriptSt, String scriptGbSq) {
		this.scriptContent = scriptContent;
		this.scriptSt = scriptSt;
		this.scriptGbSq = scriptGbSq;
	}

	public String getScriptSq() {
		return scriptSq;
	}

	public void setScriptSq(String scriptSq) {
		this.scriptSq = scriptSq;
	}

	public String getScriptContent() {
		return scriptContent;
	}

	public void setScriptContent(String scriptContent) {
		this.scriptContent = scriptContent;
	}

	public String getScriptSt() {
		return scriptSt;
	}

	public void setScriptSt(String scriptSt) {
		this.scriptSt = scriptSt;
	}

	public String getScriptGbSq() {
		return scriptGbSq;
	}

	public void setScriptGbSq(String scriptGbSq) {
		this.scriptGbSq = scriptGbSq;
	}
	
	
	
	
	

	public String[] getScriptSqs() {
		return scriptSqs;
	}

	public void setScriptSqs(String[] scriptSqs) {
		this.scriptSqs = scriptSqs;
	}

	public String[] getScriptContents() {
		return scriptContents;
	}

	public void setScriptContents(String[] scriptContents) {
		this.scriptContents = scriptContents;
	}

	public String[] getScriptSts() {
		return scriptSts;
	}

	public void setScriptSts(String[] scriptSts) {
		this.scriptSts = scriptSts;
	}

	public String[] getScriptGbSqs() {
		return scriptGbSqs;
	}

	public void setScriptGbSqs(String[] scriptGbSqs) {
		this.scriptGbSqs = scriptGbSqs;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((scriptContent == null) ? 0 : scriptContent.hashCode());
		result = prime * result + ((scriptGbSq == null) ? 0 : scriptGbSq.hashCode());
		result = prime * result + ((scriptSq == null) ? 0 : scriptSq.hashCode());
		result = prime * result + ((scriptSt == null) ? 0 : scriptSt.hashCode());
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
		ScriptVO other = (ScriptVO) obj;
		if (scriptContent == null) {
			if (other.scriptContent != null)
				return false;
		} else if (!scriptContent.equals(other.scriptContent))
			return false;
		if (scriptGbSq == null) {
			if (other.scriptGbSq != null)
				return false;
		} else if (!scriptGbSq.equals(other.scriptGbSq))
			return false;
		if (scriptSq == null) {
			if (other.scriptSq != null)
				return false;
		} else if (!scriptSq.equals(other.scriptSq))
			return false;
		if (scriptSt == null) {
			if (other.scriptSt != null)
				return false;
		} else if (!scriptSt.equals(other.scriptSt))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ScriptVO [scriptSq=" + scriptSq + ", scriptContent=" + scriptContent + ", scriptSt=" + scriptSt
				+ ", scriptGbSq=" + scriptGbSq + "]";
	}
	
	
}
