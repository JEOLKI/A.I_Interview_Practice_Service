package com.aiinterview.analysis.vo;

import com.aiinterview.script.vo.ScriptVO;

public class ScriptAnalysisVO extends ScriptVO{
	private int rank;
	private int totCnt;
	//private String scriptSq //sciptGbVO에 존재
	//private String scriptContent //sciptGbVO에 존재
	
	public ScriptAnalysisVO () {
		
	}
	
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public int getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	}

	@Override
	public String toString() {
		return "ScriptAnalysisVO [rank=" + rank
							+ ", totCnt=" + totCnt
							+ ", scriptSq=" + getScriptSq()
							+ ", scriptContent=" +getScriptContent()
							+ "]";
	}
}
