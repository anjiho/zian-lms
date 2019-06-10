package com.zianedu.lms.controller;

import com.zianedu.lms.utils.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * <PRE>
 *     1. 내용 : 교수관리 컨트롤러
 *     2. 작성자 : 안지호
 *     3. 작성일 : 2019. 04. 017k
 * </PRE>
 */
@Controller
public class TeacherManageController {

    @RequestMapping(value = "/teacherManage")
    public ModelAndView professorManage(@RequestParam(value = "page_gbn", required = false) String page_gbn) {
        ModelAndView mvc = new ModelAndView();
        Util.isNullValue(page_gbn, "");

        if("teacherCalcGraph".equals(page_gbn)) {
            mvc.setViewName("teacher/teacherCalcStatistics");
        }else if("teacherCalculateMonthList".equals(page_gbn)) {
            mvc.setViewName("teacher/teacherCalculateMonthList");
        }else if("teacherCalculateSectionList".equals(page_gbn)) {
            mvc.setViewName("teacher/teacherCalculateSectionList");
        }
        return mvc;
    }
}
