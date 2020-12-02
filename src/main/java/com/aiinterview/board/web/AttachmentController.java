package com.aiinterview.board.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.board.service.AttachmentService;
import com.aiinterview.board.vo.AttachmentVO;

@RequestMapping("/attachment")
@Controller
public class AttachmentController {
	
	@Resource(name="attachmentService")
	private AttachmentService attachmentService;
	
	@RequestMapping("/download")
	public String download(String atchSq, Model model) {

		AttachmentVO attachmentVO = new AttachmentVO();
		try {
			attachmentVO = attachmentService.retrieve(atchSq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("filepath", attachmentVO.getAtchPath());
		model.addAttribute("filename", attachmentVO.getAtchNm());
		
		return "fileDownloadView";
	}
	
}
