package com.aiinterview.interview.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.interview.service.TalentService;

@RequestMapping("/talent")
@Controller
public class TalentController {

	@Resource(name="talentService")
	private TalentService talentService;
}
