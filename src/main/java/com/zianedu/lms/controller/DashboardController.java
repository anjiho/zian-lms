package com.zianedu.lms.controller;

import com.zianedu.lms.utils.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * <PRE>
 *     1. 내용 : 대시보드 컨트롤러
 *     2. 작성자 : 안지호
 *     3. 작성일 : 2019. 04. 02
 * </PRE>
 *
 */
@Controller
public class DashboardController {

    @RequestMapping(value = "/dashboard")
    public ModelAndView dashboard(@RequestParam(value = "page_gbn", required = false) String page_gbn) {
        ModelAndView mvc = new ModelAndView();
        Util.isNullValue(page_gbn, "");

        if ("dashboard".equals(page_gbn)) {
            mvc.setViewName("dashboard/dashboard");
        } else if ("dashboard2".equals(page_gbn)) {
            mvc.setViewName("dashboard/dashboard2");
        }
        return mvc;
    }
}
