package com.aiinterview.common.view;

import java.io.FileInputStream;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

public class VideoView extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		FileInputStream fis = new FileInputStream((String)model.get("videoPath"));
		ServletOutputStream sos = response.getOutputStream();
		
		byte[] buffer = new byte[1024];
		
		while (fis.read(buffer) != -1) {
			sos.write(buffer);
		}
		
		fis.close();
		sos.flush();
		sos.close();
		
	}


}
