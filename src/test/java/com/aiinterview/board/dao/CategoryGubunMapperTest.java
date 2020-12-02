package com.aiinterview.board.dao;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.board.vo.CategoryGubunVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class CategoryGubunMapperTest extends ModelTestConfig {

	@Resource(name="categoryGubunMapper")
	private CategoryGubunMapper categoryGubunMapper;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		
		/***When***/
		List<CategoryGubunVO> categoryGubunList = categoryGubunMapper.retrieveList();

		/***Then***/
		assertEquals(4, categoryGubunList.size());
		
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		
		/***Given***/
		CategoryGubunVO categoryGubunVO = new CategoryGubunVO();
		
		/***When***/
		int result = categoryGubunMapper.retrievePagingListCnt(categoryGubunVO);

		/***Then***/
		assertEquals(4, result);
		
	}
	
	@Test
	public void retrievePagingListTest() throws Exception {
		
		/***Given***/
		CategoryGubunVO categoryGubunVO = new CategoryGubunVO();
		categoryGubunVO.setPageUnit(10);
		categoryGubunVO.setPageSize(10);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(categoryGubunVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(categoryGubunVO.getPageUnit());
		paginationInfo.setPageSize(categoryGubunVO.getPageSize());
		categoryGubunVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		categoryGubunVO.setLastIndex(paginationInfo.getLastRecordIndex());
		categoryGubunVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/***When***/
		List<CategoryGubunVO> categoryGubunList = categoryGubunMapper.retrievePagingList(categoryGubunVO);
		
		/***Then***/
		assertEquals(4, categoryGubunList.size());
		
	}
	
	@Test
	public void retrieveTest() throws Exception {
		
		/***Given***/
		String catGbSq = "1";
		
		/***When***/
		CategoryGubunVO categoryGubunVO = categoryGubunMapper.retrieve(catGbSq);
		
		/***Then***/
		assertEquals("1", categoryGubunVO.getCatGbSq());
		
	}
	
	@Test
	public void createTest() throws Exception {
		
		/***Given***/
		CategoryGubunVO categoryGubunVO = new CategoryGubunVO();
		categoryGubunVO.setCatGbContent("TESTCODE");
		categoryGubunVO.setCatGbSt("Y");
		categoryGubunVO.setBoardGbSq("1");
		
		/***When***/
		categoryGubunMapper.create(categoryGubunVO);
		
		/***Then***/
		assertEquals(5, categoryGubunMapper.retrieveList().size());
		
	}
	
	@Test
	public void updateTest() throws Exception {
		
		/***Given***/
		CategoryGubunVO categoryGubunVO = new CategoryGubunVO();
		categoryGubunVO.setCatGbSq("4");
		categoryGubunVO.setCatGbContent("TESTCODE");
		categoryGubunVO.setCatGbSt("Y");
		categoryGubunVO.setBoardGbSq("1");
		
		/***When***/
		int result = categoryGubunMapper.update(categoryGubunVO);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void deleteTest() throws Exception {
		
		/***Given***/
		String catGbSq = "1";
		
		/***When***/
		int result = categoryGubunMapper.delete(catGbSq);
		
		/***Then***/
		assertEquals(1, result);
		
	}

}
