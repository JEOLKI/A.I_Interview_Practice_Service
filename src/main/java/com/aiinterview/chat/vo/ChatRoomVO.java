package com.aiinterview.chat.vo;

public class ChatRoomVO {

	private String msgContent;
	private String msgDate;
	private String memId;
	private String memProfileNm;
	private String memProfilePath;
	private String msgArlam ;
	
	
	public String getMsgArlam() {
		return msgArlam;
	}
	public void setMsgArlam(String msgArlam) {
		this.msgArlam = msgArlam;
	}
	public String getMsgContent() {
		return msgContent;
	}
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}
	public String getMsgDate() {
		return msgDate;
	}
	public void setMsgDate(String msgDate) {
		this.msgDate = msgDate;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
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
	
	@Override
	public String toString() {
		return "ChatRoomVO [msgContent=" + msgContent + ", msgDate=" + msgDate + ", memId=" + memId + ", memProfileNm="
				+ memProfileNm + ", memProfilePath=" + memProfilePath + ", msgReceiver="+ msgArlam + "]";
	}
	
	
	
}
