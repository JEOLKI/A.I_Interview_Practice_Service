package com.aiinterview.myProfile.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/myProfile")
@Controller
public class MyProfileController {
	
	@RequestMapping(path = "/myProfile")
	public String myProfile() {
		return "myProfile/myProfile";
	}
	
	@RequestMapping(path = "/profileUpdateView")
	public String profileUpdateView() {
		return "myProfile/myProfileUpdate";
	}
	
	@RequestMapping(path = "/updateComplete")
	public String updateComplete() {
		return "myProfile/myProfile";
	}
	
	@RequestMapping(path = "/deleteMyProfile")
	public String myProfileDelete() {
		return "myProfile/myProfileDelete";
	}
	
	@RequestMapping(path = "/deleteComplete")
	public String deleteComplete() {
		return "login/view";
	}

	
}
