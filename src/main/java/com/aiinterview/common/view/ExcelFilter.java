package com.aiinterview.common.view;

import java.io.FileOutputStream;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFAutoFilter;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTAutoFilter;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTFilterColumn;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTFilters;

public class ExcelFilter {
	private static void setCellData(Sheet sheet) {

		  Object[][] data = new Object[][] {
		   new Object[] {"First name", "Last name", "Age"},
		   new Object[] {"John", "Doe", 25},
		   new Object[] {"Foo", "Bar", 20},
		   new Object[] {"Jane", "Doe", 22},
		   new Object[] {"Ruth", "Moss", 42},
		   new Object[] {"Manuel", "Doe", 32},
		   new Object[] {"Axel", "Richter", 56},
		  };

		  Row row = null;
		  Cell cell = null;
		  int r = 0;
		  int c = 0;
		  for (Object[] dataRow : data) {
		   row = sheet.createRow(r);
		   c = 0;
		   for (Object dataValue : dataRow) {
		    cell = row.createCell(c);
		    if (dataValue instanceof String) {
		     cell.setCellValue((String)dataValue);
		    } else if (dataValue instanceof Number) {
		     cell.setCellValue(((Number)dataValue).doubleValue());
		    }
		    c++;
		   }
		   r++;
		  }
		 }
	
	
		 private static void setCriteriaFilter(XSSFSheet sheet, int colId, int firstRow, int lastRow, String[] criteria) throws Exception {
		  CTAutoFilter ctAutoFilter = sheet.getCTWorksheet().getAutoFilter();
		  CTFilterColumn ctFilterColumn = null;
		  for (CTFilterColumn filterColumn : ctAutoFilter.getFilterColumnList()) {
		   if (filterColumn.getColId() == colId) ctFilterColumn = filterColumn;
		  }
		  if (ctFilterColumn == null) ctFilterColumn = ctAutoFilter.addNewFilterColumn();
		  ctFilterColumn.setColId(colId);
		  if (ctFilterColumn.isSetFilters()) ctFilterColumn.unsetFilters();

		  CTFilters ctFilters = ctFilterColumn.addNewFilters();
		  for (int i = 0; i < criteria.length; i++) {
		   ctFilters.addNewFilter().setVal(criteria[i]);
		  }

		  //hiding the rows not matching the criterias
		  DataFormatter dataformatter = new DataFormatter();
		  for (int r = firstRow; r <= lastRow; r++) {
		   XSSFRow row = sheet.getRow(r);
		   boolean hidden = true;
		   for (int i = 0; i < criteria.length; i++) {
		    String cellValue = dataformatter.formatCellValue(row.getCell(colId));
		    if (criteria[i].equals(cellValue)) hidden = false;
		   }
		   if (hidden) {
		    row.getCTRow().setHidden(hidden);
		   } else {
		    if (row.getCTRow().getHidden()) row.getCTRow().unsetHidden();
		   }
		  }
		 }

		 public static void main(String[] args) throws Exception {

		  XSSFWorkbook wb = new XSSFWorkbook();
		  XSSFSheet sheet = wb.createSheet();

		  //create rows of data
		  setCellData(sheet);

		  for (int c = 0; c < 2; c++) sheet.autoSizeColumn(c);

		  int lastRow = sheet.getLastRowNum();
		  XSSFAutoFilter autofilter = sheet.setAutoFilter(new CellRangeAddress(0, lastRow, 0, 2));
		  //XSSFAutoFilter is useless until now

		  //set filter criteria 
		  setCriteriaFilter(sheet, 1, 1, lastRow, new String[]{"Doe"});

		  //get only visible rows after filtering
		  XSSFRow row = null;
		  for (int r = 1; r <= lastRow; r++) {
		   row = sheet.getRow(r);
		   if (row.getCTRow().getHidden()) continue;
		   for (int c = 0; c < 3; c++) {
		    System.out.print(row.getCell(c) + "\t");
		   }
		   System.out.println();
		  }

		  FileOutputStream out = new FileOutputStream("AutoFilterSetTest.xlsx");
		  wb.write(out);
		  out.close();
		  wb.close();
		 }
}
