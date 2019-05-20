package com.zianedu.lms.controller;

import com.zianedu.lms.utils.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * <PRE>
 *     1. 내용 : 프로모션 상품관리 컨트롤러
 *     2. 작성자 : 안지호
 *     3. 작성일 : 2019. 04. 01
 * </PRE>
 */
@Controller
public class PromotionManageController {

    @RequestMapping(value = "/promotionManage")
    public ModelAndView promotionManage(@RequestParam(value = "page_gbn", required = false) String page_gbn) {
        ModelAndView mvc = new ModelAndView();
        Util.isNullValue(page_gbn, "");
        if("packageManage".equals(page_gbn)) {
            mvc.setViewName("promotion/packageManage");
        }else if("packageList".equals(page_gbn)) {
            mvc.setViewName("promotion/packageList");
        }else if("modifypackage".equals(page_gbn)) {
            mvc.setViewName("promotion/modifypackage");
        }else if("zianPassManage".equals(page_gbn)) {
            mvc.setViewName("promotion/zianPassManage");
        }else if("zianPassList".equals(page_gbn)) {
            mvc.setViewName("promotion/zianPassList");
        }else if("modifyZianPass".equals(page_gbn)) {
            mvc.setViewName("promotion/modifyZianPass");
        }else if("yearMemberManage".equals(page_gbn)) {
            mvc.setViewName("promotion/yearMemberManage");
        }else if("yearMemberList".equals(page_gbn)) {
            mvc.setViewName("promotion/yearMemberList");
        }else if("modifyYearMember".equals(page_gbn)) {
            mvc.setViewName("promotion/modifyYearMember");
        }

        return mvc;
    }
}
