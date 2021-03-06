package com.zianedu.lms.controller;

import com.zianedu.lms.utils.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * <PRE>
 *     1. 내용 : 통계 컨트롤러
 *     2. 작성자 : 안지호
 *     3. 작성일 : 2019. 04. 01
 * </PRE>
 */
@Controller
public class StatisManageController {

    @RequestMapping(value = "/statisManage")
    public ModelAndView statisManage(@RequestParam(value = "page_gbn", required = false) String page_gbn) {
        ModelAndView mvc = new ModelAndView();
        Util.isNullValue(page_gbn, "");

        if("productStatistics".equals(page_gbn)) {
            mvc.setViewName("statistics/productStatistics");
        } else if ("promotionStatistics".equals(page_gbn)) {
            mvc.setViewName("statistics/promotionStatistics");
        } else if ("memberStatistics".equals(page_gbn)) {
            mvc.setViewName("statistics/memberStatistics");
        }

        return mvc;
    }
}
