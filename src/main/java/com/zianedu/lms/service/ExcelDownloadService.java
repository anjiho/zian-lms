package com.zianedu.lms.service;

import com.zianedu.lms.dto.MemberListDTO;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Service
public class ExcelDownloadService extends AbstractExcelView {

    private final String DATA_LIST = "dataList";

    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest req, HttpServletResponse res) throws Exception {
        String fileName = (String)model.get("fileName");
        fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
        res.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        res.setHeader("Content-Transfer-Encoding", "binary");

        HSSFSheet sheet = null;
        String excelContent = (String)model.get("excelContent");
        sheet = createFirstSheet(workbook, model);
        String[] topMenus = (String[])model.get("topMenus");
        createColumnLabel(sheet, topMenus);

        switch (excelContent) {
            case "userList" : userListExcelDownload((List<MemberListDTO>)model.get(DATA_LIST), sheet);
            break;

            default:
            break;
        }
    }

    private void userListExcelDownload(List<MemberListDTO>dataList, HSSFSheet sheet) {
        if (dataList.size() > 0) {
            int i=0;
            for (MemberListDTO dto : dataList) {
                HSSFRow row = sheet.createRow(i + 1);
                row.createCell(0).setCellValue(dto.getUserKey());
                row.createCell(1).setCellValue(dto.getUserId());
                row.createCell(2).setCellValue(dto.getName());
                row.createCell(3).setCellValue(dto.getTelephoneMobile());
                row.createCell(4).setCellValue(dto.getEmail());
                row.createCell(5).setCellValue(dto.getIndate());
                row.createCell(6).setCellValue(dto.getAffiliationName());
                row.createCell(7).setCellValue(dto.getIsMobileReg());
                i++;
            }
        }
    }

    private HSSFSheet createFirstSheet(HSSFWorkbook workbook, Map<String, Object>model) {
        HSSFSheet sheet = workbook.createSheet();
        workbook.setSheetName(0, (String)model.get("sheetName"));
        sheet.setColumnWidth(1, 256*30);
        return sheet;
    }

    private void createColumnLabel(HSSFSheet sheet, String[] topMenus) {
        int i = 0;
        HSSFRow firstRow = sheet.createRow(0);
        for (String menus : topMenus) {
            HSSFCell cell = firstRow.createCell(i);
            cell.setCellValue(menus);
            i++;
        }
    }
}
