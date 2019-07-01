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
    public String userListExcelDownload(Model model,
                                        @RequestParam(value = "searchType") String searchType,
                                        @RequestParam(value = "searchText") String searchText,
                                        @RequestParam(value = "regStartDate") String regStartDate,
                                        @RequestParam(value = "regEndDate") String regEndDate,
                                        @RequestParam(value = "grade") String grade,
                                        @RequestParam(value = "affiliationCtgKey") String affiliationCtgKey) {
        List<MemberListDTO>dataList = memberManageMapper.selectExcelDownloadUserList(searchType, searchText, regStartDate, regEndDate, Integer.parseInt(grade), Integer.parseInt(affiliationCtgKey));
        excelContent = "userList";
        topMenus = StringUtils.getStringArray("사용자키", "아이디", "이름", "핸드폰번호", "이메일", "가입일", "직렬", "모바일 가입여부");
        fileName = "회원목록 리스트_" + Util.returnNowDateByYyyymmddhhmmss();
        sheetName = "회원목록";

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
