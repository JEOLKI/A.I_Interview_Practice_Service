package com.aiinterview.common.view;

import java.awt.Color;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.servlet.view.AbstractView;

public class ExcelDownloadView extends AbstractView {
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// model 객체에서 header, data, fileName, sheetName가져오기
		List<String> header = (List<String>) model.get("header");
		List<Map<String, String>> data = (List<Map<String, String>>) model.get("data");
		String fileName = (String) model.get("fileName");
		String sheetName = (String) model.get("sheetName");
		int titleSize = (int) model.get("titleSize");

		// excel 파일 contentType : application/vnd.ms-excel; UTF-8
		response.setContentType("application/vnd.ms-excel; UTF-8");

		// 첨부파일임을 암시
		response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ".xlsx");

		// poi 라이브러리를 이용하여 엑셀 파일을 생성

		int rowNo = 0;
		
		XSSFWorkbook xssfWb = null;
		XSSFSheet xssfSheet = null;
		XSSFRow xssfRow = null;
		XSSFCell xssfCell = null;

		xssfWb = new XSSFWorkbook();// poi 라이브러리에서는 엑셀파일을 workbook이라고 함
		xssfSheet = xssfWb.createSheet(sheetName);

		//폰트 스타일
		XSSFFont font = xssfWb.createFont();
		font.setFontName(HSSFFont.FONT_ARIAL); 
		font.setFontHeightInPoints((short)20); 
		font.setBold(true); 
		font.setColor(new XSSFColor(Color.decode("#457ba2"))); //폰트 색 지정

		//테이블 셀 스타일
		CellStyle cellStyle = xssfWb.createCellStyle();
		xssfSheet.setColumnWidth(0, (xssfSheet.getColumnWidth(0)) + (short) 2048);

		cellStyle.setFont(font); //셀 스타일 폰트 적용
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); //정렬

		//셀병합
		xssfSheet.addMergedRegion(new CellRangeAddress(0, 1, 0, titleSize-1));

		xssfRow = xssfSheet.createRow(rowNo++); //행 객체 추가
		xssfCell = xssfRow.createCell((short) 0);  //추가한 행에 셀 객체 추가
		xssfCell.setCellStyle(cellStyle); //셀에 스타일 지정
		xssfCell.setCellValue(sheetName); //데이터 입력
		
		// 행 만들기
		int rowNum = 2;
		XSSFRow row = xssfSheet.createRow(rowNum++); //빈행추가

		int column = 0;
		// header 설정
		for (String h : header) {
			// cell 만들기
			row.createCell(column++).setCellValue(h);
		}

		// data 설정
		for (Map<String, String> map : data) {
			// 행 생성
			row = xssfSheet.createRow(rowNum++);
			// 셀 채우기
			column = 0; // 매 행마다 셀 인덱스값은 초기화 되어야 함
			for (int i = 0; i < header.size(); i++) {
				row.createCell(column++).setCellValue(map.get(header.get(i)));
			}
		}
		
		for (int i=0; i<=12; i++){
			xssfSheet.autoSizeColumn(i);
			xssfSheet.setColumnWidth(i, (xssfSheet.getColumnWidth(i))+(short)1024);
		}
		
		OutputStream os = response.getOutputStream();

		xssfWb.write(os);

		os.flush();
		os.close();

		xssfWb.close();
	}

}
