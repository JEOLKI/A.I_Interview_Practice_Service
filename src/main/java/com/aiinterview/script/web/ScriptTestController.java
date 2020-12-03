package com.aiinterview.script.web;

import javax.annotation.Resource;
import javax.sound.sampled.AudioFormat;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.service.ScriptService;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
 
import com.google.gson.Gson;

@RequestMapping("/scriptTest")
@Controller
public class ScriptTestController {
	@Resource(name = "scriptService")
	private ScriptService scriptService;

	@Resource(name = "scriptGubunService")
	private ScriptGubunService scriptGbService;

	@RequestMapping(path = "/startTest.do",  method = {RequestMethod.POST})
	public String scriptTestView(Model model, String scriptGbSq){
		
		String accessKey = "8cd194e0-d925-4164-b4e0-f5c4124ae53a";    // 발급받은 API Key
		String openApiURL = null;
		String languageCode = null; 	//발음평가 코드
		String script = null;    // 스크립트
		String audioFilePath = null; // 녹음된 음성 파일 경로
		
		if(scriptGbSq.equals("5")) {
			//한국어 발음 평가
			openApiURL = "https://aiopen.etri.re.kr:8443/WiseASR/PronunciationKor";
			languageCode = "korean";
			//script = scriptContent;
			//audioFilePath = performScript;
		} else if(scriptGbSq.equals("7")) {
			//영어 발음평가
			openApiURL = "https://aiopen.etri.re.kr:8443/WiseASR/Pronunciation";
			languageCode = "english";
			//script = scriptContent;
			//audioFilePath = performScript;
		}
	        
	        String audioContents = null; 	// audioFile  byte가 들어갈 객체
	 
	        
	        //--------------
	        
	        Gson gson = new Gson();
	 
	        Map<String, Object> request = new HashMap<>();
	        Map<String, String> argument = new HashMap<>();
	 
	        try {
	            Path path = Paths.get(audioFilePath);
	            byte[] audioBytes = Files.readAllBytes(path);
	            audioContents = Base64.getEncoder().encodeToString(audioBytes);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	 
	        argument.put("language_code", languageCode);
	        argument.put("script", script);
	        argument.put("audio", audioContents);
	 
	        request.put("access_key", accessKey);
	        request.put("argument", argument);
	 
	        URL url;
	        Integer responseCode = null;
	        String responBody = null;
	        try {
	            url = new URL(openApiURL);
	            HttpURLConnection con = (HttpURLConnection)url.openConnection();
	            con.setRequestMethod("POST");
	            con.setDoOutput(true);
	 
	            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	            wr.write(gson.toJson(request).getBytes("UTF-8"));
	            wr.flush();
	            wr.close();
	 
	            responseCode = con.getResponseCode();
	            InputStream is = con.getInputStream();
	            byte[] buffer = new byte[is.available()];
	            int byteRead = is.read(buffer);
	            responBody = new String(buffer);
	 
	            System.out.println("[responseCode] " + responseCode);
	            System.out.println("[responBody]");
	            System.out.println(responBody);
	 
	        } catch (MalformedURLException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
		return "";

	}

}