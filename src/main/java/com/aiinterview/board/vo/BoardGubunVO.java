package com.aiinterview.board.vo;

public class BoardGubunVO {

	private int boardGbSq; 		// 보드구분 번호
	private String boardGbNm; 	// 보드구분 이름
	private String boardGbSt; 	// 보드구분 상태

	public int getBoardGbSq() {
		return boardGbSq;
	}

	public void setBoardGbSq(int boardGbSq) {
		this.boardGbSq = boardGbSq;
	}

	public String getBoardGbNm() {
		return boardGbNm;
	}

	public void setBoardGbNm(String boardGbNm) {
		this.boardGbNm = boardGbNm;
	}

	public String getBoardGbSt() {
		return boardGbSt;
	}

	public void setBoardGbSt(String boardGbSt) {
		this.boardGbSt = boardGbSt;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((boardGbNm == null) ? 0 : boardGbNm.hashCode());
		result = prime * result + boardGbSq;
		result = prime * result + ((boardGbSt == null) ? 0 : boardGbSt.hashCode());
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
		BoardGubunVO other = (BoardGubunVO) obj;
		if (boardGbNm == null) {
			if (other.boardGbNm != null)
				return false;
		} else if (!boardGbNm.equals(other.boardGbNm))
			return false;
		if (boardGbSq != other.boardGbSq)
			return false;
		if (boardGbSt == null) {
			if (other.boardGbSt != null)
				return false;
		} else if (!boardGbSt.equals(other.boardGbSt))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "BoardGubunVO [boardGbSq=" + boardGbSq + ", boardGbNm=" + boardGbNm + ", boardGbSt=" + boardGbSt + "]";
	}
	
	

}
