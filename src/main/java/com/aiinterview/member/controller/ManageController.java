package com.aiinterview.member.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.member.service.MemberServiceI;

@RequestMapping("/manage")
@Controller
public class ManageController {
	
	@Resource(name = "memberService") 
	private MemberServiceI memberService;



	@RequestMapping(path = "/member")
	public String manageMember() {
		return "manage/memberManage";
	} 
	
	@RequestMapping(path = "/board")
	public String manageBoard() {
		return "manage/boardManage";
	} 
	
	@RequestMapping(path = "/category")
	public String manageBoardCategory() {
		return "manage/categoryManage";
	} 
	
	@RequestMapping(path = "/plan")
	public String managePlan() {
		return "manage/planManage";
	} 
	
	@RequestMapping(path = "/script")
	public String manageScript() {
		return "manage/scriptManage";
	} 
	
	@RequestMapping(path = "/question")
	public String manageQuestion() {
		return "manage/questionManage";
	} 
	
	@RequestMapping(path = "/talent")
	public String manageTalent() {
		return "manage/talentManage";
	} 
	
	@RequestMapping(path = "/keyword")
	public String manageTalentKeyword() {
		return "manage/manageTalentKeyword";
	} 
	
	@RequestMapping(path = "/interview")
	public String manageInterview() {
		return "manage/interviewManage";
	} 
	
	@RequestMapping(path = "/left")
	public String left() {
		return "manage/left";
	} 


}
