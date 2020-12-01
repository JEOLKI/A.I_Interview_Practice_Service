package com.aiinterview.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.dao.CategoryMapper;
import com.aiinterview.board.vo.CategoryVO;

@Transactional
@Service("categoryService")
public class CategoryService {
	
	@Resource(name = "categoryMapper")
	private CategoryMapper categoryMapper;
	
	public List<CategoryVO> retrievePagingList(CategoryVO categoryVO) throws Exception {
		return categoryMapper.retrievePagingList(categoryVO);
	}
	
	public List<CategoryVO> retrieveList(CategoryVO categoryVO) throws Exception{
		return categoryMapper.retrieveList(categoryVO);
	}

	public int retrievePagingListCnt(CategoryVO categoryVO) throws Exception {
		return categoryMapper.retrievePagingListCnt(categoryVO);
	}
	
	public CategoryVO retrieve(String catSq) throws Exception{
		return categoryMapper.retrieve(catSq);
	}
	
	public void create(CategoryVO categoryVO) throws Exception{
		categoryMapper.create(categoryVO);
	}
	
	public int update(CategoryVO categoryVO) throws Exception{
		return categoryMapper.update(categoryVO);
	}
	
	public int delete(String catSq) throws Exception{
		return categoryMapper.delete(catSq);
	}
	
	
}
