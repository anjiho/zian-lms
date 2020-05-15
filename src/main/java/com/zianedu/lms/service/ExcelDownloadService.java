package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.*;
import com.zianedu.lms.dto.CashReceiptType;
import com.zianedu.lms.dto.MemberListDTO;
import com.zianedu.lms.dto.OrderExcelDownDTO;
import com.zianedu.lms.utils.Util;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.NumberFormat;
import java.util.List;
import java.util.Map;

import static com.zianedu.lms.define.datasource.MemberGradeType.getMemberGradeStr;

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
            case "orderList" : orderListExcelDownload((List<OrderExcelDownDTO>)model.get(DATA_LIST), sheet);
            break;
            default:
            break;
        }
    }

    private void userListExcelDownload(List<MemberListDTO>dataList, HSSFSheet sheet) {
        if (dataList.size() > 0) {
            int i=0;
            for (MemberListDTO dto : dataList) {
                int authority= dto.getAuthority();
                String authorityS="";
                if(authority==0) authorityS="관리자";
                if(authority==5) authorityS="강사";
                if(authority==10) authorityS="회원";
                if(authority==19) authorityS="방문객";

                String addressRoad=Util.isNullValue(dto.getAddressRoad(),"");
                String addressNumber=Util.isNullValue(dto.getAddressRoad(),"");
                if(addressRoad!="") addressRoad=addressRoad + " " + dto.getAddress();
                if(addressNumber!="") addressNumber=addressNumber + " " + dto.getAddress();

                HSSFRow row = sheet.createRow(i + 1);
                row.createCell(0).setCellValue(dto.getUserKey());
                row.createCell(1).setCellValue(dto.getUserId());
                row.createCell(2).setCellValue(dto.getName());
                row.createCell(3).setCellValue(authorityS);
                row.createCell(4).setCellValue(dto.getIndate());
                row.createCell(5).setCellValue(dto.getBirth());
                row.createCell(6).setCellValue(dto.getTelephoneMobile());
                row.createCell(7).setCellValue(dto.getTelephone());
                row.createCell(8).setCellValue(dto.getEmail());
                row.createCell(9).setCellValue(dto.getRecvEmail()==0?"X":"O");
                row.createCell(10).setCellValue(dto.getRecvSms()==0?"X":"O");
                row.createCell(11).setCellValue(dto.getZipCode());
                row.createCell(12).setCellValue(addressRoad);
                row.createCell(13).setCellValue(addressNumber);
                row.createCell(14).setCellValue(dto.getWelfareDcPercent());
                row.createCell(15).setCellValue(getMemberGradeStr(dto.getGrade()));
                row.createCell(16).setCellValue(dto.getGradeDate());
                row.createCell(17).setCellValue(dto.getAffiliationName());
                row.createCell(18).setCellValue(dto.getAffiliationName2());
                row.createCell(19).setCellValue(dto.getGradeGKey());
                row.createCell(20).setCellValue(dto.getGradePrice());
                row.createCell(21).setCellValue(dto.getNote());
                row.createCell(22).setCellValue(dto.getIsMobileReg()==1?"O":"X");
                i++;
            }
        }
    }

    private void orderListExcelDownload(List<OrderExcelDownDTO>dataList, HSSFSheet sheet) {
        if (dataList.size() > 0) {
            int i=0;
            for (OrderExcelDownDTO dto : dataList) {
                String goodsTypeName = "";
                if (dto.getPmType() == 0) {
                    goodsTypeName = GoodsType.getGoodsTypeStr(dto.getGoodsType());
                } else {
                    goodsTypeName = PromotionPmType.getPromotionPmTypeName(dto.getPmType());
                }

                String orderName = dto.getOrderGoodsName();
                /*if (dto.getOrderGoodsCount() > 0) {
                    orderName += " 외" + dto.getOrderGoodsCount();
                }*/

                String isQuickDeliver = "";
                if (!"".equals(Util.isNullValue(dto.getIsQuickDelivery(), ""))) {
                    if (dto.getIsQuickDelivery() == "1") isQuickDeliver = "ON";
                }

                String deliveryPrice = "0";
                if (!"".equals(Util.isNullValue(dto.getDeliverStatus(), ""))) deliveryPrice = "2500";


                HSSFRow row = sheet.createRow(i + 1);
                row.createCell(0).setCellValue(dto.getJKey());
                row.createCell(1).setCellValue(dto.getJId());
                row.createCell(2).setCellValue(dto.getIndate());
                row.createCell(3).setCellValue(dto.getUserId());
                row.createCell(4).setCellValue(dto.getName());
                row.createCell(5).setCellValue(dto.getTelephoneMobile());
                row.createCell(6).setCellValue(dto.getEmail());
                row.createCell(7).setCellValue(dto.getAffiliationName());
                row.createCell(8).setCellValue(dto.getStartDate());
                row.createCell(9).setCellValue(goodsTypeName);
                row.createCell(10).setCellValue(dto.getExamYear());
                row.createCell(11).setCellValue(dto.getSiteName());
                row.createCell(12).setCellValue(dto.getSubjectName());
                row.createCell(13).setCellValue(ClassificationType.getClassificationTypeStr(dto.getGoodsCtg()));
                row.createCell(14).setCellValue(dto.getTeacherNameList());
                row.createCell(15).setCellValue(orderName);
                row.createCell(16).setCellValue(dto.getIsOffline() == 0 ? "X": "O");
                row.createCell(17).setCellValue(NumberFormat.getInstance().format(dto.getGoodsPrice()));
                row.createCell(18).setCellValue(NumberFormat.getInstance().format(dto.getSellPrice()));
                row.createCell(19).setCellValue(NumberFormat.getInstance().format(dto.getPricePay()));
                row.createCell(20).setCellValue(OrderPayType.getOrderPayTypeStr(dto.getPayType()));
                row.createCell(21).setCellValue(dto.getBank());
                row.createCell(22).setCellValue(dto.getBankAccount());
                row.createCell(23).setCellValue(dto.getDepositUser());
                row.createCell(24).setCellValue(dto.getDepositDate());
                row.createCell(25).setCellValue(OrderPayStatusType.getOrderPayStatusStr(dto.getPayStatus()));
                row.createCell(26).setCellValue(dto.getIsCancelRequest() == 0 ? "X" : "O");
                row.createCell(27).setCellValue(dto.getPayStatus()==0? "":dto.getPayDate());
                row.createCell(28).setCellValue(dto.getCancelDate());
                row.createCell(29).setCellValue(dto.getIsMobile() == 0 ? "X" : "O");
                row.createCell(30).setCellValue(deliveryPrice);
                row.createCell(31).setCellValue(DeliveryStatusType.getDeliveryStatusName(Integer.parseInt(Util.isNullValue(dto.getDeliverStatus(), "0"))));
                row.createCell(32).setCellValue(dto.getDeliveryZipcode());
                row.createCell(33).setCellValue(dto.getDeliveryAddressRoad());
                row.createCell(34).setCellValue(dto.getDeliveryAddress());
                row.createCell(35).setCellValue(CashReceiptType.getCashReceiptTypeStr(dto.getCashReceiptType()));
                row.createCell(36).setCellValue(dto.getCashReceiptNumber());

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

