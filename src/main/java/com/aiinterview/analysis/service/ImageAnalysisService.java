package com.aiinterview.analysis.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.analysis.dao.ImageAnalysisMapper;
import com.aiinterview.analysis.vo.ImageAnalysisVO;

@Service("imageAnalysisService")
public class ImageAnalysisService {

	@Resource(name = "imageAnalysisMapper")
	private ImageAnalysisMapper imageAnalysisMapper;

	public List<ImageAnalysisVO> retrieveList(String ansSq) throws Exception{
		return imageAnalysisMapper.retrieveList(ansSq);
	}
	
}
