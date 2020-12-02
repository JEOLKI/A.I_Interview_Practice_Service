package com.aiinterview.chat.vo;

import java.util.Date;

public class ChatVO {

	private int msgSq               ;
	private String msgContent           ;
	private Date msgDate              ;
	private String msgSender            ;
	private String msgReceiver          ;
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((msgContent == null) ? 0 : msgContent.hashCode());
		result = prime * result + ((msgDate == null) ? 0 : msgDate.hashCode());
		result = prime * result + ((msgReceiver == null) ? 0 : msgReceiver.hashCode());
		result = prime * result + ((msgSender == null) ? 0 : msgSender.hashCode());
		result = prime * result + msgSq;
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
		ChatVO other = (ChatVO) obj;
		if (msgContent == null) {
			if (other.msgContent != null)
				return false;
		} else if (!msgContent.equals(other.msgContent))
			return false;
		if (msgDate == null) {
			if (other.msgDate != null)
				return false;
		} else if (!msgDate.equals(other.msgDate))
			return false;
		if (msgReceiver == null) {
			if (other.msgReceiver != null)
				return false;
		} else if (!msgReceiver.equals(other.msgReceiver))
			return false;
		if (msgSender == null) {
			if (other.msgSender != null)
				return false;
		} else if (!msgSender.equals(other.msgSender))
			return false;
		if (msgSq != other.msgSq)
			return false;
		return true;
	}

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

	public Date getMsgDate() {
		return msgDate;
	}

	public void setMsgDate(Date msgDate) {
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
