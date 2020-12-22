 package com.aiinterview.interview.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.set.SynchronizedSet;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.aiinterview.common.util.excel.option.ReadOption;
import com.aiinterview.common.util.excel.read.ExcelRead;
import com.aiinterview.interview.service.KeywordMatchingService;
import com.aiinterview.interview.service.KeywordService;
import com.aiinterview.interview.service.TalentService;
import com.aiinterview.interview.vo.KeywordMatchingVO;
import com.aiinterview.interview.vo.KeywordVO;
import com.aiinterview.interview.vo.TalentVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/keyword")
@Controller
public class KeywordController {

	@Resource(name="keywordService")
	private KeywordService keywordService;
	
	@Resource(name="keywordMatchingService")
	private KeywordMatchingService keywordMathingService;
	
	@Resource(name="talentService")
	private TalentService talentService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	
	@RequestMapping(path="/create.do", method = { RequestMethod.GET })
	public String create(String talentSq, String keywordContent, Model model,HttpSession session) {
		// 1. keywordContent 값으로 키워드 테이블 조회 
		// 2. 일치하는 값 있으면 매칭 테이블에 해당  조합이 있는지 검사 -> 없을 시 keywordSq, talentSq, st=Y insert, 있다면 화면돌아가서 alert
		// 3. 불일치 -> 키워드 테이블에 insert, 매칭테이블에 insert
		
		// 1.
		int keywordCnt = 0;
		int keywordSq = 0;
		int matchingCnt = 0;
		String insertMchCnt = null;
		try {
			keywordCnt = keywordService.retrieve(keywordContent);
			Map<String, String> createMap = new HashMap<>();
			
			if(keywordCnt == 0) { // 3.
				
				keywordService.create(keywordContent);
				
				keywordSq = keywordService.retrieveKeywordSq(keywordContent);
				if(keywordSq>0) {
					createMap.put("talentSq", talentSq);
					createMap.put("keywordSq", keywordSq+"");
					insertMchCnt = keywordMathingService.create(createMap);
				}
			}else { // 2.
				keywordSq = keywordService.retrieveKeywordSq(keywordContent);
				// 매칭여부 조회
				createMap.put("talentSq", talentSq);
				createMap.put("keywordSq", keywordSq+"");
				matchingCnt = keywordMathingService.retrieve(createMap);
				if(matchingCnt > 0) {
					model.addAttribute("msg", "**이미 등록된 키워드입니다.");
					return "redirect:/talent/keywordManage.do?talentSq="+talentSq; // 키워드 일치, 매칭 일치 시 되돌려보냄
				} else {
					insertMchCnt = keywordMathingService.create(createMap);
				}
			}
			
		} catch (Exception e) {
		}
		if(keywordSq != 0 || insertMchCnt !=null) {
			model.addAttribute("msg", "");
			return "redirect:/talent/keywordManage.do?talentSq="+talentSq; // 둘다 insert 성공시 redirect
		}else {
			model.addAttribute("msg", "**키워드 등록 실패");
			return "manage/talentKeywordManage"; // 키워드 일치, 매칭 일치 시 되돌려보냄
		}
		
		
	}
	
	@RequestMapping(path="/delete.do", method = {RequestMethod.POST})
	public String delete(KeywordVO keywordVO, String talentSq, Model model) {
		try {
			int deleteCnt = 0;
			for(int i =0; i<keywordVO.getKeywordSqs().length; i++) {
				if(keywordVO.getDeleteChecks()[i].equals("Y")) {
					// 1. keywordSq, talentSq 값 매칭된 행 조회  -> 해당 행 삭제
					Map<String,	String> deleteMap = new HashMap<>();
					deleteMap.put("talentSq", keywordVO.getTalentSqs()[i]);
					deleteMap.put("keywordSq", keywordVO.getKeywordSqs()[i]);
					
					deleteCnt += keywordMathingService.delete(deleteMap);
				}
			}
			return "redirect:/talent/keywordManage.do?talentSq="+talentSq;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "manage/talentKeywordManage";
	}
	
	
	/* 일괄 다운로드 */
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model, String talentSq)  {
		
		// 출력할 리스트 가져오기
		List<KeywordVO> keywordList;
		try {
			keywordList = keywordService.retrieveTalentKeywordAllList(talentSq);
			//Model 객체에 header, data
			List<String> header = new ArrayList<String>();
			header.add("KEYWORD_SQ");
			header.add("KEYWORD_CONTENT");
			
			// excel 파일 data 설정
			List<Map<String, String>> data = new ArrayList<Map<String, String>>();
			
			for(int i = 0; i<keywordList.size(); i++) {
				Map<String, String> map = new HashMap<>();
				map.put("KEYWORD_SQ", keywordList.get(i).getKeywordSq());
				map.put("KEYWORD_CONTENT", keywordList.get(i).getKeywordContent());
				data.add(map);
			}
			
			TalentVO talentVO = talentService.retrieve(talentSq);
			model.addAttribute("header",header);
			model.addAttribute("data",data);
			model.addAttribute("fileName","KEYWORD");
			model.addAttribute("sheetName",talentVO.getTalentNm());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "excelView";
	}
	
	/* 일괄 등록 */
	@RequestMapping("/massiveCreateProcess.do")
	public String createMassiveKeyword(MultipartHttpServletRequest request, String talentSq) {
		MultipartFile excelFile = request.getFile("excelFile");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택해 주세요");
		}

		File destFile = new File("D:\\" + excelFile.getOriginalFilename());
		try {
			excelFile.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			throw new RuntimeException(e.getMessage(), e);

		}

		ReadOption readOption = new ReadOption();
		readOption.setFilePath(destFile.getAbsolutePath());
		readOption.setOutputColumns("A");
		readOption.setStartRow(2);
		 
		List<Map<String, String>> excelContent = ExcelRead.read(readOption);

		for(Map<String, String> keyword : excelContent) {
			
			Map<String, String> createMap = new HashMap<>();
			
			try {
				keywordService.create(keyword.get("A"));
				int keywordSq = keywordService.retrieveKeywordSq(keyword.get("A"));
				
				createMap.put("keywordSq", keywordSq+"");
				createMap.put("talentSq", talentSq);
				
				keywordMathingService.create(createMap);
			} catch (Exception e) {
				e.printStackTrace();
			}
		  }
		
		destFile.delete();

		return "redirect:/talent/keywordManage.do?talentSq="+talentSq;

	}
	
}
