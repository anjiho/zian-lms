package com.zianedu.lms.controller;

import com.zianedu.lms.utils.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * <PRE>
 *     1. 내용 : 게시판관리 컨트롤러
 *     2. 작성자 : 안지호
 *     3. 작성일 : 2019. 04. 01
 * </PRE>
 */
@Controller
public class DataManageController {

    @RequestMapping(value = "/dataManage")
    public ModelAndView dataManage(@RequestParam(value = "page_gbn", required = false) String page_gbn) {
        ModelAndView mvc = new ModelAndView();
        Util.isNullValue(page_gbn, "");
        if("classficationSave".equals(page_gbn)) {
            mvc.setViewName("data/classficationManage");
        }else if("subjectSave".equals(page_gbn)) {
            mvc.setViewName("data/subjectManage");
        }else if("bannerSave".equals(page_gbn)) {
            mvc.setViewName("data/bannerManage");
        }else if("examplanSave".equals(page_gbn)) {
            mvc.setViewName("data/examPlanManage");
        }else if("searchSave".equals(page_gbn)) {
            mvc.setViewName("data/searchManage");
        }else if("sideBannerSave".equals(page_gbn)) {
            mvc.setViewName("data/sideBannerManage");
        }
        return mvc;
    }
}
