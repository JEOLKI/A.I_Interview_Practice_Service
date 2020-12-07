package com.aiinterview.board.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.board.service.BoardGubunService;
import com.aiinterview.board.vo.BoardGubunVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/boardGubun")
@Controller
public class BoardGubunController {
	
	@Resource(name="boardGubunService")
	private BoardGubunService boardGubunService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping(path ="/retrieveList.do")
	public String retrieveList(Model model) {
		try {
			model.addAttribute("boardGubunList", boardGubunService.retrieveList());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "jsonView";
	}
	
	@RequestMapping(value = "/retrievePagingList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrievePagingList(BoardGubunVO boardGubunVO, HttpSession session, ModelMap model) {
		

		/** EgovPropertyService.sample */
		boardGubunVO.setPageUnit(propertiesService.getInt("pageUnit"));
		boardGubunVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardGubunVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardGubunVO.getPageUnit());
		paginationInfo.setPageSize(boardGubunVO.getPageSize());

		boardGubunVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardGubunVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardGubunVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<BoardGubunVO> resultList = new ArrayList<>();
		try {
			resultList = boardGubunService.retrievePagingList(boardGubunVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("resultList", resultList);

		int totCnt = 0;
		try {
			totCnt = boardGubunService.retrievePagingListCnt(boardGubunVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "board/boardGbList";
	}
	
	@RequestMapping(value = "/create.do")
	public String create(BoardGubunVO boardGubunVO) {
		
		try {
			boardGubunService.create(boardGubunVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/boardGubun/retrievePagingList.do";
	}
	
	@RequestMapping(value = "/update.do")
	public String update(BoardGubunVO boardGubunVO) {
		
		try {
			boardGubunService.update(boardGubunVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/boardGubun/retrievePagingList.do";
	}
	
	
}
