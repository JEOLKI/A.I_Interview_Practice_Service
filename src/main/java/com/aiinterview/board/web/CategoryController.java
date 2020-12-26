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

import com.aiinterview.board.service.CategoryService;
import com.aiinterview.board.vo.CategoryVO;
import com.aiinterview.common.util.excel.option.ReadOption;
import com.aiinterview.common.util.excel.read.ExcelRead;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/category")
@Controller
public class CategoryController {
	
	@Resource(name="categoryService")
	private CategoryService categoryService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping(value = "/retrievePagingList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrievePagingList(CategoryVO categoryVO, HttpSession session, ModelMap model) {
		
		model.addAttribute("boardGbSq", categoryVO.getBoardGbSq());
		
		/** EgovPropertyService.sample */
		categoryVO.setPageUnit(propertiesService.getInt("pageUnit"));
		categoryVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(categoryVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(categoryVO.getPageUnit());
		paginationInfo.setPageSize(categoryVO.getPageSize());

		categoryVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		categoryVO.setLastIndex(paginationInfo.getLastRecordIndex());
		categoryVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<CategoryVO> resultList = new ArrayList<>();
		try {
			resultList = categoryService.retrievePagingList(categoryVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("resultList", resultList);

		int totCnt = 0;
		try {
			totCnt = categoryService.retrievePagingListCnt(categoryVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "manage/categoryManage";
	}
	
	@RequestMapping(value="/create.do")
	public String create(CategoryVO categoryVO) {
		
		try {
			categoryService.create(categoryVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/category/retrievePagingList.do?boardGbSq=" + categoryVO.getBoardGbSq();
	}
	
	@RequestMapping(value = "/update.do")
	public String update(CategoryVO categoryVO) {
		
		try {
			
			for(int i=0; i< categoryVO.getCatSqArr().length ; i++) {
				categoryVO.setCatSq(categoryVO.getCatSqArr()[i]);
				categoryVO.setCatContent(categoryVO.getCatContentArr()[i]);
				categoryVO.setCatSt(categoryVO.getCatStArr()[i]);
				categoryService.update(categoryVO);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/category/retrievePagingList.do?boardGbSq=" + categoryVO.getBoardGbSq();
	}
	
	/* 일괄 다운로드 */
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model, String boardGbSq)  {
		
		CategoryVO categoryVO = new CategoryVO(boardGbSq);
		
		// 출력할 리스트 가져오기
		List<CategoryVO> categoryList = new ArrayList<>();
		try {
			categoryList = categoryService.retrieveList(categoryVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//Model 객체에 header, data
		List<String> header = new ArrayList<String>();
		header.add("CAT_SQ");
		header.add("CAT_CONTENT");
	
		// excel 파일 data 설정
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();

		for(int i = 0; i< categoryList.size(); i++) {
			Map<String, String> map = new HashMap<>();
			map.put("CAT_SQ", categoryList.get(i).getCatSq());
			map.put("CAT_CONTENT", categoryList.get(i).getCatContent());
			data.add(map);
		}
		
		model.addAttribute("header",header);
		model.addAttribute("data",data);
		model.addAttribute("fileName","CATEGORY");
		model.addAttribute("sheetName","말머리 목록");
		model.addAttribute("titleSize", header.size());
		
		
		return "excelView";
	}
	
	/* 일괄 등록 */
	@RequestMapping("/massiveCreateProcess.do")
	public String createMassive(MultipartHttpServletRequest request, String boardGbSq) {
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
		
		CategoryVO categoryVO = new CategoryVO();
		List<Map<String, String>> excelContent = ExcelRead.read(readOption);
		for(Map<String, String> category : excelContent) {
			try {
				categoryVO.setBoardGbSq(boardGbSq);
				categoryVO.setCatContent(category.get("A"));
				categoryVO.setCatSt(category.get("B"));
				
				categoryService.create(categoryVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		  }
		
		destFile.delete();

		return "redirect:/category/retrievePagingList.do";

	}
	

}
