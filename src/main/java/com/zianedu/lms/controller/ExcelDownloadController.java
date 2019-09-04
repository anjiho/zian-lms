package com.zianedu.lms.controller;

import com.zianedu.lms.define.datasource.GoodsType;
import com.zianedu.lms.dto.MemberListDTO;
import com.zianedu.lms.dto.OrderExcelDownDTO;
import com.zianedu.lms.mapper.MemberManageMapper;
import com.zianedu.lms.mapper.OrderManageMapper;
import com.zianedu.lms.service.MemberManageService;
import com.zianedu.lms.utils.StringUtils;
import com.zianedu.lms.utils.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping(value = "/excelDownload")
public class ExcelDownloadController {

    @Autowired
    private MemberManageMapper memberManageMapper;

    @Autowired
    private OrderManageMapper orderManageMapper;

    private final String excelService = "excelService";

    public String[] topMenus = null;

    public String fileName = "";

    public String excelContent = "";

    public String sheetName = "";

    @Transactional(readOnly = true)
    @RequestMapping(value = "/userList", method = RequestMethod.POST)
    public String userListExcelDownload(Model model,
                                        @RequestParam(value = "memberSel", required = false, defaultValue = "") String searchType,
                                        @RequestParam(value = "searchText", required = false, defaultValue = "") String searchText,
                                        @RequestParam(value = "searchStartDate", required = false, defaultValue = "") String regStartDate,
                                        @RequestParam(value = "searchEndDate", required = false, defaultValue = "") String regEndDate,
                                        @RequestParam(value = "memberGradeSel", required = false, defaultValue = "0") String grade,
                                        @RequestParam(value = "sel_1", required = false, defaultValue = "0") String affiliationCtgKey) {
        List<MemberListDTO>dataList = memberManageMapper.selectExcelDownloadUserList(searchType, searchText, regStartDate, regEndDate, Integer.parseInt(grade), Integer.parseInt(affiliationCtgKey));
        excelContent = "userList";
        topMenus = StringUtils.getStringArray("사용자키", "아이디", "이름", "핸드폰번호", "이메일", "가입일", "직렬", "모바일 가입여부");
        fileName = "회원목록 리스트_" + Util.returnNowDateByYyyymmddhhmmss();
        sheetName = "회원목록";

        excelModelSetting(model, excelContent, topMenus, fileName, sheetName, dataList);
        return excelService;
    }

    @Transactional(readOnly = true)
    @RequestMapping(value = "/orderList", method = RequestMethod.POST)
    public String orderListExcelDownload(Model model,
                                        @RequestParam(value = "searchType", required = false, defaultValue = "") String searchType,
                                        @RequestParam(value = "searchText", required = false, defaultValue = "") String searchText,
                                        @RequestParam(value = "searchStartDate", required = false, defaultValue = "") String searchStartDate,
                                        @RequestParam(value = "searchEndDate", required = false, defaultValue = "") String searchEndDate,
                                        @RequestParam(value = "goodsType", required = false, defaultValue = "") String goodsType,
                                        @RequestParam(value = "payStatus", required = false, defaultValue = "0") String payStatus,
                                        @RequestParam(value = "isOffline", required = false, defaultValue = "0") String isOffline,
                                        @RequestParam(value = "payType", required = false, defaultValue = "0") String payType,
                                        @RequestParam(value = "isMobile", required = false, defaultValue = "0") String isMobile,
                                        @RequestParam(value = "isVideoReply", required = false, defaultValue = "0") String isVideoReply,
                                         @RequestParam(value = "dateSearchType", required = false, defaultValue = "") String dateSearchType) {
        List<OrderExcelDownDTO>dataList = orderManageMapper.selectExcelDownloadOrderList(
                searchStartDate, searchEndDate, GoodsType.getGoodsTypeKey(goodsType), Integer.parseInt(payStatus), Integer.parseInt(isOffline),
                Integer.parseInt(payType), Integer.parseInt(isMobile), searchText, searchType, Integer.parseInt(isVideoReply), Util.isNullValue(dateSearchType, ""));

        String title = "";
        if ("".equals(goodsType)) {
            title = "전체주문 리스트_";
        } else if ("VIDEO".equals(goodsType)) {
            if (Integer.parseInt(isVideoReply) == 0) {
                title = "동영상주문 리스트_";
            } else {
                title = "동영상주문(재수강) 리스트_";
            }
        } else if ("ACADEMY".equals(goodsType)) {
            title = "학원강의주문 리스트_";
        } else if ("BOOK".equals(goodsType)) {
            title = "도서주문 리스트_";
        } else if ("PACKAGE".equals(goodsType)) {
            title = "프로모션주문 리스트_";
        }
        excelContent = "orderList";
        topMenus = StringUtils.getStringArray("CODE", "주문번호", "주문날짜", "주문자 아이디", "주문자 이름", "주문자 휴대전화번호", "주문직렬", "주문구분", "카테고리",
                "주문내역", "오프라인 구매", "상품가격", "상품판매가", "결제금액", "결제방법", "입금예정 은행", "입금예정 계좌번호", "입금예정자 이름", "입금예정일", "결제상태",
                "취소요청", "결제날짜", "취소날짜", "모바일", "배송비", "배송상태", "수취인 이름", "수취인 전화번호", "수취인 휴대전화번호", "수취인 이메일", "배송지 우편번호",
                "배송지 주소(도로명)", "배송지 주소(지번)", "현금영수증방법", "현금영수증번호");
        fileName = title + Util.returnNowDateByYyyymmddhhmmss();
        sheetName = "목록";

        excelModelSetting(model, excelContent, topMenus, fileName, sheetName, dataList);
        return excelService;
    }

    @Transactional(readOnly = true)
    @RequestMapping(value = "/teacherList", method = RequestMethod.POST)
    public String teacherListExcelDownload(Model model,
                                         @RequestParam(value = "searchType", required = false, defaultValue = "") String searchType,
                                         @RequestParam(value = "searchText", required = false, defaultValue = "") String searchText,
                                         @RequestParam(value = "searchStartDate", required = false, defaultValue = "") String searchStartDate,
                                         @RequestParam(value = "searchEndDate", required = false, defaultValue = "") String searchEndDate) {
        List<MemberListDTO>dataList = memberManageMapper.selectExcelDownloadTeacherList(searchType, searchText, searchStartDate, searchEndDate);
        excelContent = "userList";

        topMenus = StringUtils.getStringArray("사용자키", "아이디", "이름", "핸드폰번호", "이메일", "가입일", "직렬", "모바일 가입여부");
        fileName = "강사 회원목록 리스트_" + Util.returnNowDateByYyyymmddhhmmss();
        sheetName = "강사목록";

        excelModelSetting(model, excelContent, topMenus, fileName, sheetName, dataList);
        return excelService;
    }

    @Transactional(readOnly = true)
    @RequestMapping(value = "/cancelOrderList", method = RequestMethod.POST)
    public String cancelOrderListExcelDownload(Model model,
                                         @RequestParam(value = "searchType", required = false, defaultValue = "") String searchType,
                                         @RequestParam(value = "searchText", required = false, defaultValue = "") String searchText,
                                         @RequestParam(value = "searchStartDate", required = false, defaultValue = "") String searchStartDate,
                                         @RequestParam(value = "searchEndDate", required = false, defaultValue = "") String searchEndDate,
                                         @RequestParam(value = "cancelStartDate", required = false, defaultValue = "") String cancelStartDate,
                                         @RequestParam(value = "cancelEndDate", required = false, defaultValue = "") String cancelEndDate,
                                         @RequestParam(value = "goodsType", required = false, defaultValue = "") String goodsType,
                                         @RequestParam(value = "payStatus", required = false, defaultValue = "0") String payStatus,
                                         @RequestParam(value = "isOffline", required = false, defaultValue = "0") String isOffline,
                                         @RequestParam(value = "payType", required = false, defaultValue = "0") String payType,
                                         @RequestParam(value = "isMobile", required = false, defaultValue = "0") String isMobile,
                                         @RequestParam(value = "dateSearchType", required = false, defaultValue = "payDate") String dateSearchType) {
        List<OrderExcelDownDTO>dataList = orderManageMapper.selectExcelDownloadCancelOrderList(
                searchStartDate, searchEndDate, cancelStartDate, cancelEndDate,
                Integer.parseInt(payStatus), Integer.parseInt(isOffline),
                Integer.parseInt(payType), Integer.parseInt(isMobile), searchText, searchType, dateSearchType);

        excelContent = "orderList";
        topMenus = StringUtils.getStringArray("CODE", "주문번호", "주문날짜", "주문자 아이디", "주문자 이름", "주문자 휴대전화번호", "주문직렬", "주문구분", "카테고리",
                "주문내역", "오프라인 구매", "상품가격", "상품판매가", "결제금액", "결제방법", "입금예정 은행", "입금예정 계좌번호", "입금예정자 이름", "입금예정일", "결제상태",
                "취소요청", "결제날짜", "취소날짜", "모바일", "배송비", "배송상태", "수취인 이름", "수취인 전화번호", "수취인 휴대전화번호", "수취인 이메일", "배송지 우편번호",
                "배송지 주소(도로명)", "배송지 주소(지번)", "현금영수증방법", "현금영수증번호");
        fileName = "주문,결제취소목록_" + Util.returnNowDateByYyyymmddhhmmss();
        sheetName = "목록";

        excelModelSetting(model, excelContent, topMenus, fileName, sheetName, dataList);
        return excelService;
    }

    public Model excelModelSetting(Model model, String excelContent, String[] topMenus,
                                   String fileName, String sheetName, List dataList) {
        model.addAttribute("excelContent", Util.isNullValue(excelContent, ""));
        model.addAttribute("topMenus", topMenus);
        model.addAttribute("fileName", Util.isNullValue(fileName+".xls", ""));
        model.addAttribute("sheetName", Util.isNullValue(sheetName, ""));
        model.addAttribute("dataList", dataList);
        return model;
    }
}
