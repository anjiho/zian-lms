package com.zianedu.lms.controller;

import com.zianedu.lms.utils.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * <PRE>
 *     1. 내용 : 팝업/쿠폰관리 컨트롤러
 *     2. 작성자 : 안지호
 *     3. 작성일 : 2019. 04. 01
 * </PRE>
 */
@Controller
public class PopupCouponManageController {

    @RequestMapping(value = "/popupCouponManage")
    public ModelAndView popupCouponManage(@RequestParam(value = "page_gbn", required = false) String page_gbn) {
        ModelAndView mvc = new ModelAndView();
        Util.isNullValue(page_gbn, "");
        if("popupManage".equals(page_gbn)) {
            mvc.setViewName("popup/popupManage");
        }else if("popupList".equals(page_gbn)){
            mvc.setViewName("popup/popupList");
        }else if("modifyPopup".equals(page_gbn)){
            mvc.setViewName("popup/modifyPopup");
        }
        return mvc;
    }
}
