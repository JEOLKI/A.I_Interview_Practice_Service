package com.aiinterview.board.vo;

public class CategoryGubunVO {

	private int catGbSq;
	private String catGbContent;
	private String catGbSt;
	private int boardGbSq;

	public int getCatGbSq() {
		return catGbSq;
	}

	public void setCatGbSq(int catGbSq) {
		this.catGbSq = catGbSq;
	}

	public String getCatGbContent() {
		return catGbContent;
	}

	public void setCatGbContent(String catGbContent) {
		this.catGbContent = catGbContent;
	}

	public String getCatGbSt() {
		return catGbSt;
	}

	public void setCatGbSt(String catGbSt) {
		this.catGbSt = catGbSt;
	}

	public int getBoardGbSq() {
		return boardGbSq;
	}

	public void setBoardGbSq(int boardGbSq) {
		this.boardGbSq = boardGbSq;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + boardGbSq;
		result = prime * result + ((catGbContent == null) ? 0 : catGbContent.hashCode());
		result = prime * result + catGbSq;
		result = prime * result + ((catGbSt == null) ? 0 : catGbSt.hashCode());
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
		CategoryGubunVO other = (CategoryGubunVO) obj;
		if (boardGbSq != other.boardGbSq)
			return false;
		if (catGbContent == null) {
			if (other.catGbContent != null)
				return false;
		} else if (!catGbContent.equals(other.catGbContent))
			return false;
		if (catGbSq != other.catGbSq)
			return false;
		if (catGbSt == null) {
			if (other.catGbSt != null)
				return false;
		} else if (!catGbSt.equals(other.catGbSt))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "CategoryGubunVO [catGbSq=" + catGbSq + ", catGbContent=" + catGbContent + ", catGbSt=" + catGbSt
				+ ", boardGbSq=" + boardGbSq + "]";
	}

}
