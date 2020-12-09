package com.aiinterview.script.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.script.dao.SpeechMapper;
import com.aiinterview.script.vo.SpeechVO;

@Service("speechService")
public class SpeechService {

	@Resource(name= "speechMapper")
	private SpeechMapper SpeechMapper;
	
	public int create(SpeechVO sv)throws Exception{
		return SpeechMapper.create(sv);
	}
	
	public List<SpeechVO> retrieve(SpeechVO sv)throws Exception{
		return SpeechMapper.retrieve(sv);
	}
}
