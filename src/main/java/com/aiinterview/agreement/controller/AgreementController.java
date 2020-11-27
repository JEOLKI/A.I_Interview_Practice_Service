package com.aiinterview.agreement.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/agreement")
@Controller
public class AgreementController {
	
	@RequestMapping(path = "/userAgree")
	public String userAgree() {
		return "agreement/userAgree";
	}
	
	@RequestMapping(path = "/personalAgree")
	public String personalAgree() {
		return "agreement/personalAgree";
	}
	
	@RequestMapping(path = "/marketingAgree")
	public String marketingAgree() {
		return "agreement/marketingAgree";
	}
}


