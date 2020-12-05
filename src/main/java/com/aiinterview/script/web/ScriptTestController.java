package com.aiinterview.script.web;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.service.ScriptService;

@RequestMapping("/scriptTest")
@Controller
public class ScriptTestController {
	private static final Logger logger = LoggerFactory.getLogger(ScriptTestController.class);

	@Resource(name = "scriptService")
	private ScriptService scriptService;

	@Resource(name = "scriptGubunService")
	private ScriptGubunService scriptGbService;

	@RequestMapping(path = "/startTest.do", method = { RequestMethod.POST })
	public String scriptTestProcess(Model model, String scriptContent, String scriptGbSq, String phraseDiv) {

		ScriptTestController test = new ScriptTestController();
		test.runAlgorithm();

		ArrayList<String> aList = test.ngram(scriptContent); // 스크립트에 출력된 출력 문
		ArrayList<String> bList = test.ngram(phraseDiv); 	 //사용자가 말한스크립트문

		int result = test.result_ngram(aList, bList);
		System.out.println("결과 값 : " + result);

		model.addAttribute("result", result);
		return "analysis/main.do";
	}

	public int getMinimum(int val1, int val2, int val3) {
		int minNumber = val1;
		if (minNumber > val2)
			minNumber = val2;
		if (minNumber > val3)
			minNumber = val3;
		return minNumber;
	}

	public int levenshteinDistance(char[] s, char[] t) {
		int m = s.length;
		int n = t.length;

		int[][] d = new int[m + 1][n + 1];

		for (int i = 1; i < m; i++) {
			d[i][0] = i;
		}

		for (int j = 1; j < n; j++) {
			d[0][j] = j;
		}

		for (int j = 1; j < n; j++) {
			for (int i = 1; i < m; i++) {
				if (s[i] == t[j]) {
					d[i][j] = d[i - 1][j - 1];
				} else {
					d[i][j] = getMinimum(d[i - 1][j], d[i][j - 1], d[i - 1][j - 1]) + 1;
				}
			}
		}
		return d[m - 1][n - 1];
	}

	public void runAlgorithm() {
		char[] stringA = "오늘 밥을 먹었습니다.".toCharArray();
		char[] stringB = "오늘ㅁ 밥을 먹었습니다.".toCharArray();
		// char[] stringB = "오늘 밥말고 다른거를 먹었다.".toCharArray();

		int result = levenshteinDistance(stringA, stringB);
	}

	public ArrayList<String> ngram(String text) {
		ArrayList<String> list = new ArrayList();
		ArrayList<String> result = new ArrayList();
		for (int i = 0; i <= text.length() - 1; i++) {
			list.add(Character.toString(text.charAt(i)));
		}
		for (int i = 0; i < list.size() - 1; i++) {
			// System.out.println(String.format("%s%s", list.get(i), list.get(i + 1)));
			result.add(list.get(i) + list.get(i + 1));
			System.out.println(result.get(i));
		}
		System.out.println("----------------");
		return result;
	}

	public int result_ngram(ArrayList<String> compare1, ArrayList<String> compare2) {
		long count = 0;
		long size = compare1.size();
		for (int i = 0; i < compare1.size(); i++) {
			for (int j = 0; j < compare2.size(); j++) {
				if (compare1.get(i).equals(compare2.get(j))) {
					System.out.println("일치 횟수");
					count += 1;
				}
			}
		}
		System.out.println("카운트 결과값" + count);
		System.out.println("Size" + size);
		System.out.println("compare1사이즈" + compare1.size());
		int result = (int) ((count * 100) / size);
		System.out.println("결과값" + (float) ((count * 100) / size));
		return result;
	}
}
