package com.aiinterview.member.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.member.service.MemberServiceI;
import com.aiinterview.model.MemberVo;

@RequestMapping("/manage")
@Controller
public class ManageController {
	
	@Resource(name = "memberService") 
	private MemberServiceI memberService;



	@RequestMapping(path = "/manageMember")
	public String manageMember() {
		return "manage/manageMember";
	} 
	
	@RequestMapping(path = "/manageBoard")
	public String manageBoard() {
		return "manage/manageBoard";
	} 
	
	@RequestMapping(path = "/manageBoardCategory")
	public String manageBoardCategory() {
		return "manage/manageBoardCategory";
	} 
	
	@RequestMapping(path = "/managePlan")
	public String managePlan() {
		return "manage/managePlan";
	} 
	
	@RequestMapping(path = "/manageScript")
	public String manageScript() {
		return "manage/manageScript";
	} 
	
	@RequestMapping(path = "/manageQuestion")
	public String manageQuestion() {
		return "manage/manageQuestion";
	} 
	
	@RequestMapping(path = "/manageTalent")
	public String manageTalent() {
		return "manage/manageTalent";
	} 
	
	@RequestMapping(path = "/manageTalentKeyword")
	public String manageTalentKeyword() {
		return "manage/manageTalentKeyword";
	} 
	
	@RequestMapping(path = "/manageInterview")
	public String manageInterview() {
		return "manage/manageInterview";
	} 


}
