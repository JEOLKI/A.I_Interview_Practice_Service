package com.aiinterview.board.dao;

import java.util.List;

import com.aiinterview.board.vo.CategoryGubunVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("categoryGubunMapper")
public interface CategoryGubunMapper {
	
	public List<CategoryGubunVO> retrieveList() throws Exception;
	
	public List<CategoryGubunVO> retrievePagingList(CategoryGubunVO categoryGubunVO) throws Exception;
	
	public int retrievePagingListCnt(CategoryGubunVO categoryGubunVO) throws Exception;

	public CategoryGubunVO retrieve(String catGbSq) throws Exception;

	public void create(CategoryGubunVO categoryGubunVO) throws Exception;

	public int update(CategoryGubunVO categoryGubunVO) throws Exception;
	
	public int delete(String catGbSq) throws Exception;
	
}
