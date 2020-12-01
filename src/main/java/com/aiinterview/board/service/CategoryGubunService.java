package com.aiinterview.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.dao.CategoryGubunMapper;
import com.aiinterview.board.vo.CategoryGubunVO;

@Transactional
@Service("categoryGubunService")
public class CategoryGubunService {
	
	@Resource(name = "categoryGubunMapper")
	private CategoryGubunMapper categoryGubunMapper;
	
	public List<CategoryGubunVO> retrievePagingList(CategoryGubunVO categoryGubunVO) throws Exception {
		return categoryGubunMapper.retrievePagingList(categoryGubunVO);
	}
	
	public List<CategoryGubunVO> retrieveList() throws Exception{
		return categoryGubunMapper.retrieveList();
	}

	public int retrievePagingListCnt(CategoryGubunVO categoryGubunVO) throws Exception {
		return categoryGubunMapper.retrievePagingListCnt(categoryGubunVO);
	}
	
	public CategoryGubunVO retrieve(String catGbSq) throws Exception{
		return categoryGubunMapper.retrieve(catGbSq);
	}
	
	public String create(CategoryGubunVO categoryGubunVO) throws Exception{
		categoryGubunMapper.create(categoryGubunVO);
		return categoryGubunVO.getCatGbSq();
	}
	
	public int update(CategoryGubunVO categoryGubunVO) throws Exception{
		return categoryGubunMapper.update(categoryGubunVO);
	}
	
	public int delete(String catGbSq) throws Exception{
		return categoryGubunMapper.delete(catGbSq);
	}
}
