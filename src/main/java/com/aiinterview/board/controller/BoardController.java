package com.aiinterview.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.aiinterview.board.model.AtchFileVo;
import com.aiinterview.board.model.BoardVo;
import com.aiinterview.board.service.BoardServiceI;
import com.aiinterview.common.model.PageVo;
import com.aiinterview.common.util.FileUploadUtil;

@RequestMapping("/board")
@Controller
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Resource(name = "boardService")
	private BoardServiceI boardService;
	
	@RequestMapping(path = "/list", method = {RequestMethod.GET})
	public String list(int gubun_sq,
					   @RequestParam(name="page", defaultValue = "1", required = false) int page,
					   @RequestParam(name="pageSize", defaultValue = "10", required = false ) int pageSize,
					   Model model) {
		
		PageVo pageVo = new PageVo(gubun_sq, page, pageSize);
		Map<String, Object> map = boardService.getBoardPageList(pageVo);
		model.addAttribute("cpage", page);
		model.addAttribute("pages", map.get("pages"));
		model.addAttribute("boardList", map.get("boardList"));
		model.addAttribute("gubun_sq", gubun_sq);
		
		return "tiles/board/boardList";
	}
	
	@RequestMapping(path = "/detail", method = {RequestMethod.GET})
	public String boardDetail(int board_sq,
							  Model model) {
		
		Map<String, Object> map = boardService.getBoard(board_sq);
		model.addAttribute("boardVo", map.get("boardVo"));
		model.addAttribute("atchFileList", map.get("atchFileList"));
		model.addAttribute("replyList", map.get("replyList"));
		
		return "tiles/board/board";
	}
	
	@RequestMapping(path = "/regist", method = {RequestMethod.GET})
	public String registView(int gubun_sq, String userid, Model model,
							 @RequestParam(name="group_no", defaultValue = "0", required = false) int group_no,
							 @RequestParam(name="board_sq", defaultValue = "0", required = false) int board_p_sq
							 ) {
		model.addAttribute("gubun_sq", gubun_sq);
		model.addAttribute("board_p_sq", board_p_sq);
		model.addAttribute("userid", userid);
		model.addAttribute("group_no", group_no);
		
		return "tiles/board/boardRegister";
	}
	
	@RequestMapping(path = "/regist", method = {RequestMethod.POST})
	public String registProcess(BoardVo boardVo, MultipartHttpServletRequest mtfRequest) {

		logger.debug("boardVo : {}", boardVo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardVo", boardVo);
		
		logger.debug("mtfRequest : {}", mtfRequest.getFiles("file"));

		List<MultipartFile> fileList = mtfRequest.getFiles("file");

		AtchFileVo atchFileVo;
		List<AtchFileVo> atchFileList = new ArrayList<AtchFileVo>();
		
		for (MultipartFile file : fileList) {
			
			if(file.getSize() > 0) {
					String fileName = file.getOriginalFilename();
					String extension = FileUploadUtil.getExtension(fileName);
					String filePath = "D:\\attachment\\" + UUID.randomUUID().toString() + "." + extension ;
					File uploadFile = new File(filePath);
					atchFileVo = new AtchFileVo(filePath, fileName);
					atchFileList.add(atchFileVo);
					try {
						file.transferTo(uploadFile);
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
			}
		}
		
		logger.debug("atchFileList : {}", atchFileList);
		map.put("atchFileList", atchFileList);
		int boardCurSq = boardService.insertBoard(map);
		
		return "redirect:"+ mtfRequest.getContextPath() +"/board/detail?board_sq="+boardCurSq;
	}
	
	@RequestMapping(path = "/update", method = {RequestMethod.GET})
	public String updateView(int board_sq, Model model) {
		Map<String, Object> map = boardService.getBoard(board_sq);
		BoardVo boardVo = (BoardVo) map.get("boardVo");
		List<AtchFileVo> atchFileList = (List<AtchFileVo>)map.get("atchFileList");
		
		model.addAttribute("boardVo", boardVo);
		model.addAttribute("atchFileList", atchFileList);
		
		return "tiles/board/boardUpdate";
	}
	
	@RequestMapping(path = "/update", method = {RequestMethod.POST})
	public String updateProcess(BoardVo boardVo, 
								@RequestParam(required = false) List<String> deleteAtchSq,
								MultipartHttpServletRequest mtfRequest) {
		
		logger.debug("boardVo : {} ",boardVo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardVo", boardVo);
		map.put("deleteAtchSq", deleteAtchSq);
		
		List<MultipartFile> fileList = mtfRequest.getFiles("file");

		List<AtchFileVo> atchFileList = new ArrayList<AtchFileVo>();
		
		for (MultipartFile file : fileList) {
			
			if(file.getSize() > 0) {
					String fileName = file.getOriginalFilename();
					String extension = FileUploadUtil.getExtension(fileName);
					String filePath = "D:\\attachment\\" + UUID.randomUUID().toString() + "." + extension ;
					File uploadFile = new File(filePath);
					AtchFileVo atchFileVo = new AtchFileVo(filePath, fileName);
					atchFileList.add(atchFileVo);
					try {
						file.transferTo(uploadFile);
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
			}
		}
		logger.debug("atchFileList : {}", atchFileList);
		map.put("atchFileList", atchFileList);
		int boardCurSq = boardService.updateBoard(map);
		return "redirect:"+mtfRequest.getContextPath()+"/board/detail?board_sq="+boardCurSq;
	}
	
	@RequestMapping(path = "/delete", method = {RequestMethod.GET})
	public String deleteProcess(int board_sq, int gubun_sq, String gubun_nm,
								HttpServletRequest request) {
		int deleteCnt = boardService.deleteBoard(board_sq);
		if ( deleteCnt == 1 ) {
			return "redirect:" + request.getContextPath() + "/board/list?gubun_sq=" + gubun_sq + "&gubun_nm=" + gubun_nm;
		} else {
			return "main";
		}
	}
	
}
