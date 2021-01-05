package com.aiinterview.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.dao.AttachmentMapper;
import com.aiinterview.board.vo.AttachmentVO;

@Service("attachmentService")
public class AttachmentService {
	
	@Resource(name = "attachmentMapper")
	private AttachmentMapper attachmentMapper;
	
	public List<AttachmentVO> retrieveList(String boardSq) throws Exception{
		return attachmentMapper.retrieveList(boardSq);
	}
	
	public AttachmentVO retrieve(String atchSq) throws Exception{
		return attachmentMapper.retrieve(atchSq);
	}
	
	public void create(AttachmentVO attachmentVO) throws Exception{
		attachmentMapper.create(attachmentVO);
	}
	
	public int delete(String atchSq) throws Exception{
		return attachmentMapper.delete(atchSq);
	}
	
}
