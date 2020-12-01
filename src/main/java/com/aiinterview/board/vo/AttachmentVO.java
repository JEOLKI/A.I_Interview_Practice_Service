package com.aiinterview.board.vo;

import com.aiinterview.base.vo.BaseVO;

public class AttachmentVO extends BaseVO {

	private String atchSq; // 첨부파일 번호
	private String boardSq; // 게시글 번호
	private String atchNm; // 파일 이름
	private String atchPath; // 파일 경로

	public AttachmentVO() {

	}

	public AttachmentVO(String atchNm, String atchPath) {
		this.atchNm = atchNm;
		this.atchPath = atchPath;
	}

	public String getAtchSq() {
		return atchSq;
	}

	public void setAtchSq(String atchSq) {
		this.atchSq = atchSq;
	}

	public String getBoardSq() {
		return boardSq;
	}

	public void setBoardSq(String boardSq) {
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
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((atchNm == null) ? 0 : atchNm.hashCode());
		result = prime * result + ((atchPath == null) ? 0 : atchPath.hashCode());
		result = prime * result + ((atchSq == null) ? 0 : atchSq.hashCode());
		result = prime * result + ((boardSq == null) ? 0 : boardSq.hashCode());
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
		if (atchSq == null) {
			if (other.atchSq != null)
				return false;
		} else if (!atchSq.equals(other.atchSq))
			return false;
		if (boardSq == null) {
			if (other.boardSq != null)
				return false;
		} else if (!boardSq.equals(other.boardSq))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "AttachmentVO [atchSq=" + atchSq + ", boardSq=" + boardSq + ", atchNm=" + atchNm + ", atchPath="
				+ atchPath + "]";
	}

}
