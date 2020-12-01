package com.aiinterview.board.dao;

import java.util.List;

import com.aiinterview.board.vo.CategoryVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("categoryMapper")
public interface CategoryMapper {

	public List<CategoryVO> retrieveList(CategoryVO categoryVO) throws Exception;
	
	public List<CategoryVO> retrievePagingList(CategoryVO categoryVO) throws Exception;

	public int retrievePagingListCnt(CategoryVO categoryVO) throws Exception;
	
	public CategoryVO retrieve(String catSq) throws Exception;

	public void create(CategoryVO categoryVO) throws Exception;

	public int update(CategoryVO categoryVO) throws Exception;
	
	public int delete(String catSq) throws Exception;
	
}
