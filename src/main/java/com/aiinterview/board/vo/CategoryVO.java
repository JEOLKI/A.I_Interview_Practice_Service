package com.aiinterview.board.vo;

import com.aiinterview.common.vo.BaseVO;

public class CategoryVO extends BaseVO {

	private String catSq;
	private String catContent;
	private String catSt;
	private String boardGbSq;
	
	private String[] catSqArr;
	private String[] catContentArr;
	private String[] catStArr;
	private String[] boardGbSqArr;
	
	public String[] getCatSqArr() {
		return catSqArr;
	}

	public void setCatSqArr(String[] catSqArr) {
		this.catSqArr = catSqArr;
	}

	public String[] getCatContentArr() {
		return catContentArr;
	}

	public void setCatContentArr(String[] catContentArr) {
		this.catContentArr = catContentArr;
	}

	public String[] getCatStArr() {
		return catStArr;
	}

	public void setCatStArr(String[] catStArr) {
		this.catStArr = catStArr;
	}

	public String[] getBoardGbSqArr() {
		return boardGbSqArr;
	}

	public void setBoardGbSqArr(String[] boardGbSqArr) {
		this.boardGbSqArr = boardGbSqArr;
	}

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
