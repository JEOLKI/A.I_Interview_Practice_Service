package com.aiinterview.chat.vo;

public class ChatVO {

	private int msgSq               ;
	private String msgContent           ;
	private String msgDate              ;
	private String msgSender            ;
	private String msgReceiver          ;


	public int getMsgSq() {
		return msgSq;
	}

	public void setMsgSq(int msgSq) {
		this.msgSq = msgSq;
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

	public String getMsgSender() {
		return msgSender;
	}

	public void setMsgSender(String msgSender) {
		this.msgSender = msgSender;
	}

	public String getMsgReceiver() {
		return msgReceiver;
	}

	public void setMsgReceiver(String msgReceiver) {
		this.msgReceiver = msgReceiver;
	}

	@Override
	public String toString() {
		return "ChatVO [msgSq=" + msgSq + ", msgContent=" + msgContent + ", msgDate=" + msgDate + ", msgSender="
				+ msgSender + ", msgReceiver=" + msgReceiver + "]";
	}
	
	
	
}
