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
	public String planListView(Model model) {
		
		return "plan/planList";
	}
	
	@RequestMapping(path = "/planListAjax.do", method = RequestMethod.GET)
	public String buyplanAjax(Model model) {
		List<PlanVO> planList;
		try {
			planList = planService.planList();
			model.addAttribute("planList", planList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		return "jsonView";
	}
	
	@RequestMapping(path = "/planContent.do", method = RequestMethod.GET)
	public String planContentView(PlanVO pv, Model model, HttpSession session) {
		
		PlanVO pvContent;
		try {
			pvContent = planService.planContent(pv);
			PlanUseVO puv = new PlanUseVO();
			MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
			puv.setMemId(mv.getMemId());
			
			int planUseCheck = planService.planUseCheck(puv);
			
			model.addAttribute("planUseCheck", planUseCheck);
			model.addAttribute("pvContent", pvContent);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		return "plan/planContent";
	}
	
	
	@RequestMapping(path = "/payPlanAjax.do", method = RequestMethod.GET)
	public String payPlanAjax(PlanVO pv, Model model) {
		
		PlanVO pvContent;
		try {
			pvContent = planService.planContent(pv);
			model.addAttribute("pvContent", pvContent);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "jsonView";
	}
	
	
	@RequestMapping(path = "/planUseCreate.do", method = RequestMethod.GET)
	public String planUseCreateView(PlanVO pv, HttpSession session) {
		
		
		PlanVO pvContent;
		try {
			pvContent = planService.planContent(pv);
			PlanUseVO puv = new PlanUseVO();
			puv.setPlanPeriod(pvContent.getPlanPeriod());
			
			MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
			puv.setMemId(mv.getMemId());
			
			
			planService.planUseCreate(puv);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "member/membermain";
	}
	
	
	@RequestMapping(path = "/manage.do", method = RequestMethod.GET)
	public String createView() {
		
		return "manage/planManage";
	}
	
	
	
	@RequestMapping(path = "/create.do", method =  RequestMethod.POST)
	public String createProcess(PlanVO pv) {
		try {
			planService.create(pv);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "manage/planManage";
	}

	@RequestMapping(path = "/update.do", method = RequestMethod.GET)
	public String updateView(PlanVO pv) {
		
		try {
			planService.update(pv);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "manage/planManage";
	}
	
	
	@RequestMapping(path = "/totalPayList.do")
	public String totalPayList(HttpSession session) {
		PlanUseVO puv = new PlanUseVO();
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		puv.setMemId(mv.getMemId());
		try {
			planService.CashList(puv);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "plan/totalPayList";
	}
	
	
	
	
	
	
	
	@RequestMapping(path = "/createe.do", method = RequestMethod.GET)
	public String createeView() {
		
		return "manage/planManagee";
	}
	
	
	
	@RequestMapping(path = "/payComplete.do")
	public String payComplete() {
		return "myProfile/myProfile";
	}
	
	
	
	
	
	@RequestMapping(path = "/buyPlanTest.do", method = RequestMethod.GET)
	public String buyPlanTest(Model model) {
		return "plan/buyPlanTest";
	}
	
	
	
	
}
