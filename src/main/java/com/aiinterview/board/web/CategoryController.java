package com.aiinterview.board.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.board.service.CategoryService;
import com.aiinterview.board.vo.CategoryVO;

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

		return "";
	}
	
	@RequestMapping(value = "/create.do")
	public String create(CategoryVO categoryVO) {
		
		try {
			categoryService.create(categoryVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}
	
	@RequestMapping(value = "/update.do")
	public String update(CategoryVO categoryVO) {
		
		try {
			categoryService.update(categoryVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}
	

}
