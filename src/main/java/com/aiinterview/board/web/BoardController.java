package com.aiinterview.board.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.aiinterview.board.service.BoardService;
import com.aiinterview.board.vo.AttachmentVO;
import com.aiinterview.board.vo.BoardVO;
import com.aiinterview.common.util.FileUploadUtil;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/board")
@Controller
public class BoardController {
	
	@Resource(name="boardService")
	private BoardService boardService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping(value = "/retrievePagingList.do")
	public String retrievePagingList(String boardGbSq, String boardGbNm, BoardVO boardVO, ModelMap model) throws Exception {
		
		model.addAttribute("boardGbSq", boardGbSq);
		model.addAttribute("boardGbNm", boardGbNm);
		
		boardVO.setBoardGbSq(boardGbSq);

		/** EgovPropertyService.sample */
		boardVO.setPageUnit(propertiesService.getInt("pageUnit"));
		boardVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<BoardVO> resultList = boardService.retrievePagingList(boardVO);
		model.addAttribute("resultList", resultList);

		int totCnt = boardService.retrievePagingListCnt(boardVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "board/list";
	}
	
	@RequestMapping(path = "/create.do", method = { RequestMethod.GET })
	public String create(int boardGbSq, String memId, Model model,
						 @RequestParam(name="groupNo", defaultValue = "0", required = false) int groupNo,
						 @RequestParam(name="boardSq", defaultValue = "0", required = false) int parentSq
						 ) {
		model.addAttribute("boardGbSq", boardGbSq);
		model.addAttribute("parentSq", parentSq);
		model.addAttribute("memId", memId);
		model.addAttribute("groupNo", groupNo);
		
		return "board/create";
	}
	
	@RequestMapping(path = "/create.do", method = { RequestMethod.POST })
	public String create(BoardVO boardVO, MultipartHttpServletRequest mtfRequest) throws Exception {

		logger.debug("boardVO : {}", boardVO);
		logger.debug("mtfRequest : {}", mtfRequest.getFiles("file"));

		
		List<MultipartFile> fileList = mtfRequest.getFiles("file");

		AttachmentVO attachmentVO;
		List<AttachmentVO> attachmentList = new ArrayList<AttachmentVO>();
		
		for (MultipartFile file : fileList) {
			
			if(file.getSize() > 0) {
					String fileName = file.getOriginalFilename();
					String extension = FileUploadUtil.getExtension(fileName);
					String filePath = "D:\\attachment\\" + UUID.randomUUID().toString() + "." + extension ;
					File uploadFile = new File(filePath);
					attachmentVO = new AttachmentVO(fileName, filePath);
					attachmentList.add(attachmentVO);
					try {
						file.transferTo(uploadFile);
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
			}
		}
		
		logger.debug("atchFileList : {}", attachmentList);
		
		String boardSq = boardService.create(boardVO);
		
		return "redirect:"+ mtfRequest.getContextPath() +"/board/retrieve?board_sq="+boardSq;
	}
	
	
}
