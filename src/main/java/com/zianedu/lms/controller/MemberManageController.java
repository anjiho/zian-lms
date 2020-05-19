package com.zianedu.lms.controller;

import com.zianedu.lms.utils.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * <PRE>
 *     1. 내용 : 회원관리 컨트롤러
 *     2. 작성자 : 안지호
 *     3. 작성일 : 2019. 04. 01
 * </PRE>
 */
@Controller
public class MemberManageController {

    @RequestMapping(value = "/memberManage")
    public ModelAndView memeberManage(@RequestParam(value = "page_gbn", required = false) String page_gbn) {
        ModelAndView mvc = new ModelAndView();
        Util.isNullValue(page_gbn, "");
        if("memberList".equals(page_gbn)) {
            mvc.setViewName("member/memberList");
        }else if("memeberSecessionList".equals(page_gbn)) {
            mvc.setViewName("member/memeberSecessionList");
        }else if("counselList".equals(page_gbn)) {
            mvc.setViewName("member/counselList");
        }else if("counselManage".equals(page_gbn)) {
            mvc.setViewName("member/counselManage");
        }else if("modifyCounsel".equals(page_gbn)) {
            mvc.setViewName("member/modifyCounsel");
        }else if("memberManage".equals(page_gbn)) {
            mvc.setViewName("member/memberManage");
        }else if("teacherList".equals(page_gbn)) {
            mvc.setViewName("member/teacherList");
        }else if("teacherManage".equals(page_gbn)) {
            mvc.setViewName("member/teacherManage");
        }else if("modifyTeacher".equals(page_gbn)) {
            mvc.setViewName("member/modifyTeacher");
        }else if("sendSms".equals(page_gbn)) {
            mvc.setViewName("member/sendSms");
        }else if("smsSendList".equals(page_gbn)) {
            mvc.setViewName("member/smsSendList");
        }else if("mileageManage".equals(page_gbn)) {
            mvc.setViewName("member/mileageManage");
        }

        return mvc;
    }

}
