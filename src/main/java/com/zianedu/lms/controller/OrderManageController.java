package com.zianedu.lms.controller;

import com.zianedu.lms.utils.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * <PRE>
 *     1. 내용 : 주문관리 컨트롤러
 *     2. 작성자 : 안지호
 *     3. 작성일 : 2019. 04. 01
 * </PRE>
 */
@Controller
public class OrderManageController {

    @RequestMapping(value = "/orderManage")
    public ModelAndView orderManage(@RequestParam(value = "page_gbn", required = false) String page_gbn) {
        ModelAndView mvc = new ModelAndView();
        Util.isNullValue(page_gbn, "");
        if("orderList".equals(page_gbn)) {
            mvc.setViewName("order/orderList");
        }else if("orderDetailManage".equals(page_gbn)) {
            mvc.setViewName("order/orderDetailManage");
        }else if("playOrderList".equals(page_gbn)) {
            mvc.setViewName("order/playOrderList");
        }else if("academyLectureOrderList".equals(page_gbn)) {
            mvc.setViewName("order/academyLectureOrderList");
        }else if("bookOrderList".equals(page_gbn)) {
            mvc.setViewName("order/bookOrderList");
        }else if("promotionOrderList".equals(page_gbn)) {
            mvc.setViewName("order/promotionOrderList");
        }else if("cancelOrderList".equals(page_gbn)) {
            mvc.setViewName("order/cancelOrderList");
        }
        return mvc;
    }
}
