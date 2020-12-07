package com.aiinterview.board.vo;

import com.aiinterview.base.vo.BaseVO;

public class CategoryVO extends BaseVO {

	private String catSq;
	private String catContent;
	private String catSt;
	private String boardGbSq;

	public CategoryVO() {

	}

	public CategoryVO(String boardGbSq) {
		this.boardGbSq = boardGbSq;
	}

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

	public String getBoardGbSq() {
		return boardGbSq;
	}

	public void setBoardGbSq(String boardGbSq) {
		this.boardGbSq = boardGbSq;
	}

	

}
