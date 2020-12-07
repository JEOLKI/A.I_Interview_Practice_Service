package com.aiinterview.board.service;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.board.vo.CategoryVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class CategoryServiceTest extends ModelTestConfig{

	@Resource(name="categoryService")
	private CategoryService categoryService;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		CategoryVO categoryVO = new CategoryVO();
		categoryVO.setBoardGbSq("1");
		
		/***When***/
		List<CategoryVO> categoryList = categoryService.retrieveList(categoryVO);

		/***Then***/
		assertEquals(5, categoryList.size());
		
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		
		/***Given***/
		CategoryVO categoryVO = new CategoryVO();
		
		/***When***/
		int result = categoryService.retrievePagingListCnt(categoryVO);

		/***Then***/
		assertEquals(5, result);
		
	}
	
	@Test
	public void retrievePagingListTest() throws Exception {
		
		/***Given***/
		CategoryVO categoryVO = new CategoryVO();
		categoryVO.setPageUnit(10);
		categoryVO.setPageSize(10);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(categoryVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(categoryVO.getPageUnit());
		paginationInfo.setPageSize(categoryVO.getPageSize());
		categoryVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		categoryVO.setLastIndex(paginationInfo.getLastRecordIndex());
		categoryVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/***When***/
		List<CategoryVO> categoryList = categoryService.retrievePagingList(categoryVO);
		
		/***Then***/
		assertEquals(5, categoryList.size());
		
	}
	
	@Test
	public void retrieveTest() throws Exception {
		
		/***Given***/
		String catSq = "1";
		
		/***When***/
		CategoryVO categoryVO = categoryService.retrieve(catSq);
		
		/***Then***/
		assertEquals("1", categoryVO.getCatSq());
		
	}
	
	@Test
	public void createTest() throws Exception {
		
		/***Given***/
		CategoryVO categoryVO = new CategoryVO();
		categoryVO.setCatContent("TESTCODE");
		categoryVO.setCatSt("Y");
		
		/***When***/
		categoryService.create(categoryVO);
		
		/***Then***/
		assertEquals(6, categoryService.retrieveList(categoryVO).size());
		
	}
	
	@Test
	public void updateTest() throws Exception {
		
		/***Given***/
		CategoryVO categoryVO = new CategoryVO();
		categoryVO.setCatSq("4");
		categoryVO.setCatContent("TESTCODE");
		categoryVO.setCatSt("N");
		
		/***When***/
		int result = categoryService.update(categoryVO);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void deleteTest() throws Exception {
		
		/***Given***/
		String catSq = "7";
		
		/***When***/
		int result = categoryService.delete(catSq);
		
		/***Then***/
		assertEquals(1, result);
		
	}

}
