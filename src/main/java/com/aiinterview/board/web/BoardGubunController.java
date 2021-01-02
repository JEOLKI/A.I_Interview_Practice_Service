package com.aiinterview.board.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.aiinterview.board.service.BoardGubunService;
import com.aiinterview.board.vo.BoardGubunVO;
import com.aiinterview.common.util.excel.option.ReadOption;
import com.aiinterview.common.util.excel.read.ExcelRead;

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
	
	@RequestMapping(value="/retrieveList.do")
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
			if(!boardGubunVO.getSearchUseYn().equals("Y")) { // 검색한 것이 아니면
				boardGubunVO.setSearchKeyword("");	// 검색어 비워주기
			} else if(boardGubunVO.getSearchUseYn().equals("Y") && boardGubunVO.getSearchKeyword().equals("")) { // 검색한 뒤에 검색어를 비웠다면 
				boardGubunVO.setSearchUseYn("N");	// 검색여부를 N으로 전환
			}
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

		return "manage/boardGbManage";
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
			for(int i=0; i< boardGubunVO.getBoardGbSqArr().length ; i++) {
				boardGubunVO.setBoardGbNm(boardGubunVO.getBoardGbNmArr()[i]);
				boardGubunVO.setBoardGbSq(boardGubunVO.getBoardGbSqArr()[i]);
				boardGubunVO.setBoardGbSt(boardGubunVO.getBoardGbStArr()[i]);
				boardGubunService.update(boardGubunVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/boardGubun/retrievePagingList.do";
	}
	
	/* 일괄 다운로드 */
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model)  {
		
		// 출력할 리스트 가져오기
		List<BoardGubunVO> boardGubunList = new ArrayList<>();
		try {
			boardGubunList = boardGubunService.retrieveList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//Model 객체에 header, data
		List<String> header = new ArrayList<String>();
		header.add("번호");
		header.add("게시판이름");
		header.add("사용여부");
	
		// excel 파일 data 설정
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();

		for(int i = 0; i< boardGubunList.size(); i++) {
			Map<String, String> map = new HashMap<>();
			map.put("번호", boardGubunList.get(i).getBoardGbSq());
			map.put("게시판이름", boardGubunList.get(i).getBoardGbNm());
			map.put("사용여부", boardGubunList.get(i).getBoardGbSt());
			data.add(map);
		}
		
		model.addAttribute("header",header);
		model.addAttribute("data",data);
		model.addAttribute("fileName","BOARDGUBUN");
		model.addAttribute("sheetName","게시판 목록");
		model.addAttribute("titleSize", header.size());
		
		return "excelView";
	}
	
	/* 일괄 등록 */
	@RequestMapping("/massiveCreateProcess.do")
	public String createMassive(MultipartHttpServletRequest request) {
		
		MultipartFile excelFile = request.getFile("excelFile");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택해 주세요");
		}

		File destFile = new File("D:\\" + excelFile.getOriginalFilename());
		try {
			excelFile.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			throw new RuntimeException(e.getMessage(), e);

		}

		ReadOption readOption = new ReadOption();
		readOption.setFilePath(destFile.getAbsolutePath());
		readOption.setOutputColumns("A");
		readOption.setOutputColumns("B");
		readOption.setStartRow(2);
		
		BoardGubunVO boardGubunVO = new BoardGubunVO();
		List<Map<String, String>> excelContent = ExcelRead.read(readOption);
		for(Map<String, String> boardGubun : excelContent) {
			try {
				
				boardGubunVO.setBoardGbNm(boardGubun.get("A"));
				boardGubunVO.setBoardGbSt(boardGubun.get("B"));
				
				boardGubunService.create(boardGubunVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		  }
		
		destFile.delete();

		return "redirect:/boardGubun/retrievePagingList.do";
	}
	
	@RequestMapping(value="/statistic.do")
	public String statistic(Model model) {
		return "manage/boardGbStatistics";
	}
	
	@RequestMapping(value="/retrieveStatistics.do")
	public String retrieveStatistics(Model model) {
		
		try {
			List<BoardGubunVO> boardGbList = boardGubunService.retrieveStatistics();
			model.addAttribute("boardGbList", boardGbList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
	}
	
}
