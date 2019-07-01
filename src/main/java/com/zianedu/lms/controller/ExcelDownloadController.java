package com.zianedu.lms.controller;

import com.zianedu.lms.dto.MemberListDTO;
import com.zianedu.lms.mapper.MemberManageMapper;
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
    private MemberManageService memberManageService;

    @Autowired
    private MemberManageMapper memberManageMapper;

    private final String excelService = "excelService";

    public String[] topMenus = null;

    public String fileName = "";

    public String excelContent = "";

    public String sheetName = "";

    //sPage, 10, searchType, searchText, regStartDate, regEndDate, grade, affiliationCtgKey,
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
