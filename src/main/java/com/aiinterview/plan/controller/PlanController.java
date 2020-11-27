package com.aiinterview.plan.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/plan")
@Controller
public class PlanController {

	@RequestMapping(path = "/buyPlan")
	public String buyPlanView() {
		return "plan/buyPlan";
	}
	
	@RequestMapping(path = "/payPlan")
	public String payPlan() {
		return "plan/payPlan";
	}

	@RequestMapping(path = "/payComplete")
	public String payComplete() {
		return "myProfile/myProfile";
	}
	
	@RequestMapping(path = "/totalPayList")
	public String totalPayList() {
		return "plan/totalPayList";
	}
}
