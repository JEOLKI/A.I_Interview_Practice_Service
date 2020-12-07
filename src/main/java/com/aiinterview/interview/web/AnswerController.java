package com.aiinterview.interview.web;

import java.io.File;
import java.sql.Blob;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

@RequestMapping("/answer")
@Controller
public class AnswerController {
	
	@RequestMapping(path="/test.do", method= {RequestMethod.POST})
	public String ss(File fd){
		
		return "";
	}
	
}
