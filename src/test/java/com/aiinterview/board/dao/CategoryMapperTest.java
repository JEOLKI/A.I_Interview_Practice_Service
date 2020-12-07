package com.aiinterview.board.dao;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.board.vo.CategoryVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class CategoryMapperTest extends ModelTestConfig {

	@Resource(name="categoryMapper")
	private CategoryMapper categoryMapper;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		CategoryVO categoryVO = new CategoryVO();
		categoryVO.setBoardGbSq("1");
		
		/***When***/
		List<CategoryVO> categoryList = categoryMapper.retrieveList(categoryVO);

		/***Then***/
		assertEquals(2, categoryList.size());
		
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		
		/***Given***/
		CategoryVO categoryVO = new CategoryVO();
		
		/***When***/
		int result = categoryMapper.retrievePagingListCnt(categoryVO);

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
		List<CategoryVO> categoryList = categoryMapper.retrievePagingList(categoryVO);
		
		/***Then***/
		assertEquals(5, categoryList.size());
		
	}
	
	@Test
	public void retrieveTest() throws Exception {
		
		/***Given***/
		String catSq = "1";
		
		/***When***/
		CategoryVO categoryVO = categoryMapper.retrieve(catSq);
		
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
		categoryMapper.create(categoryVO);
		
		/***Then***/
		assertEquals(6, categoryMapper.retrieveList(categoryVO).size());
		
	}
	
	@Test
	public void updateTest() throws Exception {
		
		/***Given***/
		CategoryVO categoryVO = new CategoryVO();
		categoryVO.setCatSq("1");
		categoryVO.setCatContent("TESTCODE");
		categoryVO.setCatSt("N");
		
		/***When***/
		int result = categoryMapper.update(categoryVO);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void deleteTest() throws Exception {
		
		/***Given***/
		String catSq = "1";
		
		/***When***/
		int result = categoryMapper.delete(catSq);
		
		/***Then***/
		assertEquals(1, result);
		
	}

}
