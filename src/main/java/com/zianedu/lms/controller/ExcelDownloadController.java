package com.zianedu.lms.controller;

import com.zianedu.lms.dto.MemberListDTO;
import com.zianedu.lms.service.MemberManageService;
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
        List<MemberListDTO>dataList = memberManageService.getMemeberList(1, 0, searchType, searchText, regStartDate, regEndDate, Integer.parseInt(grade), Integer.parseInt(affiliationCtgKey));
        excelContent = "userList";
        return null;
    }
}
