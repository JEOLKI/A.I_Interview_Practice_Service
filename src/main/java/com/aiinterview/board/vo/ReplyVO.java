package com.aiinterview.board.vo;

import com.aiinterview.base.vo.BaseVO;

public class ReplyVO extends BaseVO {

	private String replySq;
	private String boardSq;
	private String replyContent;
	private String replyDate;
	private String replySt;
	private String memId;

	public String getReplySq() {
		return replySq;
	}

	public void setReplySq(String replySq) {
		this.replySq = replySq;
	}

	public String getBoardSq() {
		return boardSq;
	}

	public void setBoardSq(String boardSq) {
		this.boardSq = boardSq;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public String getReplyDate() {
		return replyDate;
	}

	public void setReplyDate(String replyDate) {
		this.replyDate = replyDate;
	}

	public String getReplySt() {
		return replySt;
	}

	public void setReplySt(String replySt) {
		this.replySt = replySt;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((boardSq == null) ? 0 : boardSq.hashCode());
		result = prime * result + ((memId == null) ? 0 : memId.hashCode());
		result = prime * result + ((replyContent == null) ? 0 : replyContent.hashCode());
		result = prime * result + ((replyDate == null) ? 0 : replyDate.hashCode());
		result = prime * result + ((replySq == null) ? 0 : replySq.hashCode());
		result = prime * result + ((replySt == null) ? 0 : replySt.hashCode());
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
		ReplyVO other = (ReplyVO) obj;
		if (boardSq == null) {
			if (other.boardSq != null)
				return false;
		} else if (!boardSq.equals(other.boardSq))
			return false;
		if (memId == null) {
			if (other.memId != null)
				return false;
		} else if (!memId.equals(other.memId))
			return false;
		if (replyContent == null) {
			if (other.replyContent != null)
				return false;
		} else if (!replyContent.equals(other.replyContent))
			return false;
		if (replyDate == null) {
			if (other.replyDate != null)
				return false;
		} else if (!replyDate.equals(other.replyDate))
			return false;
		if (replySq == null) {
			if (other.replySq != null)
				return false;
		} else if (!replySq.equals(other.replySq))
			return false;
		if (replySt == null) {
			if (other.replySt != null)
				return false;
		} else if (!replySt.equals(other.replySt))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ReplyVO [replySq=" + replySq + ", boardSq=" + boardSq + ", replyContent=" + replyContent
				+ ", replyDate=" + replyDate + ", replySt=" + replySt + ", memId=" + memId + "]";
	}

}
