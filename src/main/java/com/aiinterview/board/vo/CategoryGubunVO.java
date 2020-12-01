package com.aiinterview.board.vo;

import com.aiinterview.base.vo.BaseVO;

public class CategoryGubunVO extends BaseVO {

	private String catGbSq;
	private String catGbContent;
	private String catGbSt;
	private String boardGbSq;

	public String getCatGbSq() {
		return catGbSq;
	}

	public void setCatGbSq(String catGbSq) {
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

	public String getBoardGbSq() {
		return boardGbSq;
	}

	public void setBoardGbSq(String boardGbSq) {
		this.boardGbSq = boardGbSq;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((boardGbSq == null) ? 0 : boardGbSq.hashCode());
		result = prime * result + ((catGbContent == null) ? 0 : catGbContent.hashCode());
		result = prime * result + ((catGbSq == null) ? 0 : catGbSq.hashCode());
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
		if (boardGbSq == null) {
			if (other.boardGbSq != null)
				return false;
		} else if (!boardGbSq.equals(other.boardGbSq))
			return false;
		if (catGbContent == null) {
			if (other.catGbContent != null)
				return false;
		} else if (!catGbContent.equals(other.catGbContent))
			return false;
		if (catGbSq == null) {
			if (other.catGbSq != null)
				return false;
		} else if (!catGbSq.equals(other.catGbSq))
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
