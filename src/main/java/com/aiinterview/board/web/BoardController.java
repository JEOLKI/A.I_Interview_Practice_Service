package com.aiinterview.board.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.aiinterview.board.service.CategoryService;
import com.aiinterview.board.vo.AttachmentVO;
import com.aiinterview.board.vo.BoardGroupVO;
import com.aiinterview.board.vo.BoardVO;
import com.aiinterview.board.vo.CategoryVO;
import com.aiinterview.common.util.FileUploadUtil;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/board")
@Controller
public class BoardController {
	
	@Resource(name="boardService")
	private BoardService boardService;
	
	@Resource(name="categoryService")
	private CategoryService categoryService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping(value = "/retrievePagingList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrievePagingList(BoardVO boardVO, String boardGbSq, String boardGbNm, HttpSession session, ModelMap model) {
		
		session.setAttribute("boardGbSq", boardGbSq);
		session.setAttribute("boardGbNm", boardGbNm);
		
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

		List<BoardVO> resultList = new ArrayList<>();
		try {
			resultList = boardService.retrievePagingList(boardVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("resultList", resultList);

		int totCnt = 0;
		try {
			totCnt = boardService.retrievePagingListCnt(boardVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "board/boardList";
	}
	
	@RequestMapping(path = "/retrieve.do", method = {RequestMethod.GET})
	public String boardDetail(String boardSq,
							  Model model) {
		
		BoardGroupVO boardGroupVO = new BoardGroupVO();
		try {
			boardGroupVO = boardService.retrieve(boardSq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("boardVO", boardGroupVO.getBoardVO());
		model.addAttribute("attachmentList", boardGroupVO.getAttachmentList());
		model.addAttribute("replyList", boardGroupVO.getReplyList());
		
		return "board/boardDetail";
	}
	
	@RequestMapping(path = "/create.do", method = { RequestMethod.GET })
	public String create(String boardGbSq, String boardGbNm, Model model,
						 @RequestParam(name="groupNo", defaultValue = "0", required = false) int groupNo,
						 @RequestParam(name="boardSq", defaultValue = "0", required = false) int parentSq) {
		try {
			model.addAttribute("categoryList", categoryService.retrieveList(new CategoryVO(boardGbSq)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("parentSq", parentSq);
		model.addAttribute("groupNo", groupNo);
		model.addAttribute("boardGbSq", boardGbSq);
		model.addAttribute("boardGbNm", boardGbNm);
		
		return "board/boardCreate";
	}
	
	@RequestMapping(value = "/create.do", method = { RequestMethod.POST })
	public String create(BoardVO boardVO, MultipartHttpServletRequest mtfRequest) {
		
		logger.debug("boardVO : {}", boardVO);
		boardVO.setBoardSt("Y");
		
		BoardGroupVO boardGroupVO = new BoardGroupVO();
		boardGroupVO.setBoardVO(boardVO);
		
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
		boardGroupVO.setAttachmentList(attachmentList);
		String boardSq = "";
		try {
			boardSq = boardService.create(boardGroupVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:"+ mtfRequest.getContextPath() +"/board/retrieve.do?boardSq="+boardSq;
	}
	
	@RequestMapping(path = "/delete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String delete(String boardSq, String boardGbSq, HttpServletRequest request) {
		
		int deleteCnt = 0;
		try {
			deleteCnt = boardService.delete(boardSq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if ( deleteCnt == 1 ) {
			return "redirect:" + request.getContextPath() + "/board/retrievePagingList.do?boardGbSq=" + boardGbSq ;
		} else {
			return "main";
		}
	}
	
	@RequestMapping(path = "/update.do", method = {RequestMethod.GET})
	public String updateView(String boardSq, String boardGbSq, Model model) {
		BoardGroupVO boardGroupVO = new BoardGroupVO();
		try {
			boardGroupVO = boardService.retrieve(boardSq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		BoardVO boardVO = boardGroupVO.getBoardVO();
		List<AttachmentVO> attachmentList = boardGroupVO.getAttachmentList();
		
		try {
			model.addAttribute("categoryList", categoryService.retrieveList(new CategoryVO(boardGbSq)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("attachmentList", attachmentList);
		
		return "board/boardUpdate";
	}
	
	@RequestMapping(path = "/update.do", method = {RequestMethod.POST})
	public String updateProcess(BoardVO boardVO,
								@RequestParam(required = false) List<String> deleteAtchSq,
								MultipartHttpServletRequest mtfRequest) {
		
		logger.debug("boardVO : {}", boardVO);
		boardVO.setBoardSt("Y");
		
		BoardGroupVO boardGroupVO = new BoardGroupVO();
		boardGroupVO.setBoardVO(boardVO);
		boardGroupVO.setDeleteAtchSqList(deleteAtchSq);
		
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
		
		boardGroupVO.setAttachmentList(attachmentList);
		
		String boardSq = "";
		try {
			boardSq = boardService.update(boardGroupVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:"+ mtfRequest.getContextPath() +"/board/retrieve.do?boardSq="+boardSq;
	}
	
	
}
