package com.aiinterview.board.vo;

public class AttachmentVO {

	private int atchSq;			// 첨부파일 번호
	private int boardSq;		// 게시글 번호
	private String atchNm;		// 파일 이름
	private String atchPath;	// 파일 경로

	public int getAtchSq() {
		return atchSq;
	}

	public void setAtchSq(int atchSq) {
		this.atchSq = atchSq;
	}

	public int getBoardSq() {
		return boardSq;
	}

	public void setBoardSq(int boardSq) {
		this.boardSq = boardSq;
	}

	public String getAtchNm() {
		return atchNm;
	}

	public void setAtchNm(String atchNm) {
		this.atchNm = atchNm;
	}

	public String getAtchPath() {
		return atchPath;
	}

	public void setAtchPath(String atchPath) {
		this.atchPath = atchPath;
	}

	@Override
	public String toString() {
		return "AttachmentVO [atchSq=" + atchSq + ", boardSq=" + boardSq + ", atchNm=" + atchNm + ", atchPath="
				+ atchPath + ", getAtchSq()=" + getAtchSq() + ", getBoardSq()=" + getBoardSq() + ", getAtchNm()="
				+ getAtchNm() + ", getAtchPath()=" + getAtchPath() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString() + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((atchNm == null) ? 0 : atchNm.hashCode());
		result = prime * result + ((atchPath == null) ? 0 : atchPath.hashCode());
		result = prime * result + atchSq;
		result = prime * result + boardSq;
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
		AttachmentVO other = (AttachmentVO) obj;
		if (atchNm == null) {
			if (other.atchNm != null)
				return false;
		} else if (!atchNm.equals(other.atchNm))
			return false;
		if (atchPath == null) {
			if (other.atchPath != null)
				return false;
		} else if (!atchPath.equals(other.atchPath))
			return false;
		if (atchSq != other.atchSq)
			return false;
		if (boardSq != other.boardSq)
			return false;
		return true;
	}

}
