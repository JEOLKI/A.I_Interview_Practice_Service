package com.aiinterview.plan.web;


import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.member.vo.MemberVO;
import com.aiinterview.member.web.LoginController;
import com.aiinterview.plan.service.PlanService;
import com.aiinterview.plan.vo.PlanUseVO;
import com.aiinterview.plan.vo.PlanVO;

@RequestMapping("/plan")
@Controller
public class PlanController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Resource(name = "planService")
	PlanService planService;
	
	@RequestMapping(path = "/planList.do", method = RequestMethod.GET)
	public String planListView() {
		return "plan/planList";
	}
	
	@RequestMapping(path = "/planListAjax.do", method = RequestMethod.GET)
	public String buyplanAjax(Model model) {
		List<PlanVO> planList =  planService.planList();

		model.addAttribute("planList", planList);
		
		return "jsonView";
	}
	
	@RequestMapping(path = "/planContent.do", method = RequestMethod.GET)
	public String planContentView(PlanVO pv, Model model) {
		
		PlanVO pvContent =  planService.planContent(pv);
	
		model.addAttribute("pvContent", pvContent);
		return "plan/planContent";
	}
	
	@RequestMapping(path = "/payPlanAjax.do", method = RequestMethod.GET)
	public String payPlanAjax(PlanVO pv, Model model) {
		
		PlanVO pvContent =  planService.planContent(pv);
		
		model.addAttribute("pvContent", pvContent);
		
		return "jsonView";
	}
	
	
	@RequestMapping(path = "/planUseCreate.do", method = RequestMethod.GET)
	public String planUseCreateView(PlanVO pv, HttpSession session) {
		
		PlanVO pvContent =  planService.planContent(pv);
		PlanUseVO puv = new PlanUseVO();
		puv.setPlanPeriod(pvContent.getPlanPeriod());
		
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		puv.setMemId(mv.getMemId());
		
		planService.planUseCreate(puv);
		
		return "member/membermain";
	}
	

	
	
	
	
	@RequestMapping(path = "/payComplete.do")
	public String payComplete() {
		return "myProfile/myProfile";
	}
	
	@RequestMapping(path = "/totalPayList.do")
	public String totalPayList() {
		return "plan/totalPayList";
	}
	
	
	
	
	@RequestMapping(path = "/buyPlanTest.do", method = RequestMethod.GET)
	public String buyPlanTest(Model model) {
		return "plan/buyPlanTest";
	}
	
	
	
	
}
