package com.aiinterview.board.vo;

public class CategoryVO extends CategoryGubunVO{

	private String catSq;
	private String catContent;
	private String catSt;
	private String catGbSq;

	public String getCatSq() {
		return catSq;
	}

	public void setCatSq(String catSq) {
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

	public String getCatGbSq() {
		return catGbSq;
	}

	public void setCatGbSq(String catGbSq) {
		this.catGbSq = catGbSq;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((catContent == null) ? 0 : catContent.hashCode());
		result = prime * result + ((catGbSq == null) ? 0 : catGbSq.hashCode());
		result = prime * result + ((catSq == null) ? 0 : catSq.hashCode());
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
		if (catGbSq == null) {
			if (other.catGbSq != null)
				return false;
		} else if (!catGbSq.equals(other.catGbSq))
			return false;
		if (catSq == null) {
			if (other.catSq != null)
				return false;
		} else if (!catSq.equals(other.catSq))
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
