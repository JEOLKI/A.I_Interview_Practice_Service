package com.aiinterview.analysis.vo;

import com.aiinterview.script.vo.ScriptGubunVO;

public class ScriptGbAnalysisVO extends ScriptGubunVO{
	private int rn;
	private String scriptGbContent;
	private String percent;
	private int scriptGbCount;
	
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	public String getScriptGbContent() {
		return scriptGbContent;
	}
	public void setScriptGbContent(String scriptGbContent) {
		this.scriptGbContent = scriptGbContent;
	}
	public String getPercent() {
		return percent;
	}
	public void setPercent(String percent) {
		this.percent = percent;
	}
	public int getScriptGbCount() {
		return scriptGbCount;
	}
	public void setScriptGbCount(int scriptGbCount) {
		this.scriptGbCount = scriptGbCount;
	}
	
	
}
