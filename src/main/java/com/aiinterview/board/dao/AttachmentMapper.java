package com.aiinterview.board.dao;

import java.util.List;

import com.aiinterview.board.vo.AttachmentVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("attachmentMapper")
public interface AttachmentMapper {
	
	public List<AttachmentVO> retrieveList(String boardSq) throws Exception;
	
	public AttachmentVO retrieve(String atchSq) throws Exception;
	
	public void create(AttachmentVO attachmentVO) throws Exception;
	
	public int delete(String atchSq) throws Exception;
	
}
