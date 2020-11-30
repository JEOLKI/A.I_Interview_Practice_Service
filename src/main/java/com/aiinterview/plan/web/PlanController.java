package com.aiinterview.plan.web;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.plan.service.PlanService;
import com.aiinterview.plan.vo.PlanVo;

@RequestMapping("/plan")
@Controller
public class PlanController {
	
	
	@Resource(name = "planService")
	PlanService planService;
	
	@RequestMapping(path = "/buyplan.do", method = RequestMethod.GET)
	public String buyPlanView(Model model) {
		
		return "plan/buyPlan";
	}
	
	@RequestMapping(path = "/buyPlanTest.do", method = RequestMethod.GET)
	public String buyPlanTest(Model model) {
		
		return "plan/buyPlanTest";
	}
	
	
	@RequestMapping(path = "/buyplanajax.do", method = RequestMethod.GET)
	public String buyplanAjax(Model model) {
		List<PlanVo> planList =  planService.planList();

		System.out.println(planList.get(0));
		System.out.println(planList.get(1));
		System.out.println(planList.get(2));

		model.addAttribute("planList", planList);
		
		return "jsonView";
	}
	
	
	
	
	@RequestMapping(path = "/payPlan.do")
	public String payPlan() {
		return "plan/payPlan";
	}

	@RequestMapping(path = "/payComplete.do")
	public String payComplete() {
		return "myProfile/myProfile";
	}
	
	@RequestMapping(path = "/totalPayList.do")
	public String totalPayList() {
		return "plan/totalPayList";
	}
}
