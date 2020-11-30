package com.aiinterview.board.vo;

public class CategoryVO {

	private int catSq;
	private String catContent;
	private String catSt;
	private int catGbSq;

	public int getCatSq() {
		return catSq;
	}

	public void setCatSq(int catSq) {
		this.catSq = catSq;
	}

	public String getCatContent() {
		return catContent;
	}

	public void setCatContent(String catContent) {
		this.catContent = catContent;
	}

	public String getCatSt() {
		return catSt;
	}

	public void setCatSt(String catSt) {
		this.catSt = catSt;
	}

	public int getCatGbSq() {
		return catGbSq;
	}

	public void setCatGbSq(int catGbSq) {
		this.catGbSq = catGbSq;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((catContent == null) ? 0 : catContent.hashCode());
		result = prime * result + catGbSq;
		result = prime * result + catSq;
		result = prime * result + ((catSt == null) ? 0 : catSt.hashCode());
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
		CategoryVO other = (CategoryVO) obj;
		if (catContent == null) {
			if (other.catContent != null)
				return false;
		} else if (!catContent.equals(other.catContent))
			return false;
		if (catGbSq != other.catGbSq)
			return false;
		if (catSq != other.catSq)
			return false;
		if (catSt == null) {
			if (other.catSt != null)
				return false;
		} else if (!catSt.equals(other.catSt))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "CategoryVO [catSq=" + catSq + ", catContent=" + catContent + ", catSt=" + catSt + ", catGbSq=" + catGbSq
				+ "]";
	}

}
