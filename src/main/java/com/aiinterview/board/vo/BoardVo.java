package com.aiinterview.board.vo;

import javax.xml.bind.annotation.XmlRootElement;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

@JsonInclude(Include.NON_NULL)
@XmlRootElement(name = "boardVo")
public class BoardVO {

	private int boardSq;			// 게시글 번호
	private int boardGbSq;			// 게시글 구분 번호
	private String boardTitle;		// 게시글 제목
	private String boardContent;	// 게시글 내용
	private String boardDate;		// 게시글 등록일자
	private String boardSt;			// 게시글 상태
	private int groupNo;			// 게시글 그룹 번호
	private int parentSq;			// 게시글 부모 번호
	private String memId;			// 회원 아이디

	public int getBoardSq() {
		return boardSq;
	}

	public void setBoardSq(int boardSq) {
		this.boardSq = boardSq;
	}

	public int getBoardGbSq() {
		return boardGbSq;
	}

	public void setBoardGbSq(int boardGbSq) {
		this.boardGbSq = boardGbSq;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public String getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}

	public String getBoardSt() {
		return boardSt;
	}

	public void setBoardSt(String boardSt) {
		this.boardSt = boardSt;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public int getParentSq() {
		return parentSq;
	}

	public void setParentSq(int parentSq) {
		this.parentSq = parentSq;
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
		result = prime * result + ((boardContent == null) ? 0 : boardContent.hashCode());
		result = prime * result + ((boardDate == null) ? 0 : boardDate.hashCode());
		result = prime * result + boardGbSq;
		result = prime * result + boardSq;
		result = prime * result + ((boardSt == null) ? 0 : boardSt.hashCode());
		result = prime * result + ((boardTitle == null) ? 0 : boardTitle.hashCode());
		result = prime * result + groupNo;
		result = prime * result + ((memId == null) ? 0 : memId.hashCode());
		result = prime * result + parentSq;
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
		BoardVO other = (BoardVO) obj;
		if (boardContent == null) {
			if (other.boardContent != null)
				return false;
		} else if (!boardContent.equals(other.boardContent))
			return false;
		if (boardDate == null) {
			if (other.boardDate != null)
				return false;
		} else if (!boardDate.equals(other.boardDate))
			return false;
		if (boardGbSq != other.boardGbSq)
			return false;
		if (boardSq != other.boardSq)
			return false;
		if (boardSt == null) {
			if (other.boardSt != null)
				return false;
		} else if (!boardSt.equals(other.boardSt))
			return false;
		if (boardTitle == null) {
			if (other.boardTitle != null)
				return false;
		} else if (!boardTitle.equals(other.boardTitle))
			return false;
		if (groupNo != other.groupNo)
			return false;
		if (memId == null) {
			if (other.memId != null)
				return false;
		} else if (!memId.equals(other.memId))
			return false;
		if (parentSq != other.parentSq)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "BoardVO [boardSq=" + boardSq + ", boardGbSq=" + boardGbSq + ", boardTitle=" + boardTitle
				+ ", boardContent=" + boardContent + ", boardDate=" + boardDate + ", boardSt=" + boardSt + ", groupNo="
				+ groupNo + ", parentSq=" + parentSq + ", memId=" + memId + "]";
	}

}
