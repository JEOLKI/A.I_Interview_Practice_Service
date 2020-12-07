package com.aiinterview.board.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.board.service.CategoryGubunService;
import com.aiinterview.board.vo.CategoryGubunVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/categoryGubun")
@Controller
public class CategoryGubunController {
	
	@Resource(name="categoryGubunService")
	private CategoryGubunService categoryGubunService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping(value = "/retrievePagingList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrievePagingList(CategoryGubunVO categoryGubunVO, HttpSession session, ModelMap model) {
		

		/** EgovPropertyService.sample */
		categoryGubunVO.setPageUnit(propertiesService.getInt("pageUnit"));
		categoryGubunVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(categoryGubunVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(categoryGubunVO.getPageUnit());
		paginationInfo.setPageSize(categoryGubunVO.getPageSize());

		categoryGubunVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		categoryGubunVO.setLastIndex(paginationInfo.getLastRecordIndex());
		categoryGubunVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<CategoryGubunVO> resultList = new ArrayList<>();
		try {
			resultList = categoryGubunService.retrievePagingList(categoryGubunVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("resultList", resultList);

		int totCnt = 0;
		try {
			totCnt = categoryGubunService.retrievePagingListCnt(categoryGubunVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "";
	}
	
	@RequestMapping(value = "/create.do")
	public String create(CategoryGubunVO categoryGubunVO) {
		
		try {
			categoryGubunService.create(categoryGubunVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}
	
	@RequestMapping(value = "/update.do")
	public String update(CategoryGubunVO categoryGubunVO) {
		
		try {
			categoryGubunService.update(categoryGubunVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}

}
