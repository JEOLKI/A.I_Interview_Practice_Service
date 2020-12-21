package com.aiinterview.board.vo;

import java.util.List;

public class BoardGroupVO {

	private AttachmentVO attachmentVO;
	private BoardGubunVO boardGubunVO;
	private BoardVO boardVO;
	private CategoryVO categoryVO;
	private ReplyVO replyVO;
	
	private List<AttachmentVO> attachmentList;
	private List<ReplyVO> replyList;
	
	private List<String> deleteAtchSqList;
	
	public List<String> getDeleteAtchSqList() {
		return deleteAtchSqList;
	}

	public void setDeleteAtchSqList(List<String> deleteAtchSqList) {
		this.deleteAtchSqList = deleteAtchSqList;
	}

	public List<ReplyVO> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<ReplyVO> replyList) {
		this.replyList = replyList;
	}

	public List<AttachmentVO> getAttachmentList() {
		return attachmentList;
	}

	public void setAttachmentList(List<AttachmentVO> attachmentList) {
		this.attachmentList = attachmentList;
	}

	public AttachmentVO getAttachmentVO() {
		return attachmentVO;
	}

	public void setAttachmentVO(AttachmentVO attachmentVO) {
		this.attachmentVO = attachmentVO;
	}

	public BoardGubunVO getBoardGubunVO() {
		return boardGubunVO;
	}

	public void setBoardGubunVO(BoardGubunVO boardGubunVO) {
		this.boardGubunVO = boardGubunVO;
	}

	public BoardVO getBoardVO() {
		return boardVO;
	}

	public void setBoardVO(BoardVO boardVO) {
		this.boardVO = boardVO;
	}

	public CategoryVO getCategoryVO() {
		return categoryVO;
	}

	public void setCategoryVO(CategoryVO categoryVO) {
		this.categoryVO = categoryVO;
	}

	public ReplyVO getReplyVO() {
		return replyVO;
	}

	public void setReplyVO(ReplyVO replyVO) {
		this.replyVO = replyVO;
	}

}
