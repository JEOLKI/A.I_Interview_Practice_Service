package com.aiinterview.board.vo;

public class ReplyVO {

	private int replySq;
	private int boardSq;
	private int replyContent;
	private int replyDate;
	private int replySt;
	private int memId;

	public int getReplySq() {
		return replySq;
	}

	public void setReplySq(int replySq) {
		this.replySq = replySq;
	}

	public int getBoardSq() {
		return boardSq;
	}

	public void setBoardSq(int boardSq) {
		this.boardSq = boardSq;
	}

	public int getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(int replyContent) {
		this.replyContent = replyContent;
	}

	public int getReplyDate() {
		return replyDate;
	}

	public void setReplyDate(int replyDate) {
		this.replyDate = replyDate;
	}

	public int getReplySt() {
		return replySt;
	}

	public void setReplySt(int replySt) {
		this.replySt = replySt;
	}

	public int getMemId() {
		return memId;
	}

	public void setMemId(int memId) {
		this.memId = memId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + boardSq;
		result = prime * result + memId;
		result = prime * result + replyContent;
		result = prime * result + replyDate;
		result = prime * result + replySq;
		result = prime * result + replySt;
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
		if (boardSq != other.boardSq)
			return false;
		if (memId != other.memId)
			return false;
		if (replyContent != other.replyContent)
			return false;
		if (replyDate != other.replyDate)
			return false;
		if (replySq != other.replySq)
			return false;
		if (replySt != other.replySt)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ReplyVO [replySq=" + replySq + ", boardSq=" + boardSq + ", replyContent=" + replyContent
				+ ", replyDate=" + replyDate + ", replySt=" + replySt + ", memId=" + memId + "]";
	}

}
