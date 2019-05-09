package com.zianedu.lms.controller;

import com.zianedu.lms.utils.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * <PRE>
 *     1. 내용 : 상품관리 컨트롤러
 *     2. 작성자 : 안지호
 *     3. 작성일 : 2019. 04. 01
 * </PRE>
 */
@Controller
public class ProductManageController {

    @RequestMapping(value = "/productManage")
    public ModelAndView productManage(@RequestParam(value = "page_gbn", required = false) String page_gbn) {
        ModelAndView mvc = new ModelAndView();
        Util.isNullValue(page_gbn, "");
        if("playSave".equals(page_gbn)) {
            mvc.setViewName("product/playManage");
        }else if("playList".equals(page_gbn)) {
            mvc.setViewName("product/playList");
        }else if("modifyPlayManage".equals(page_gbn)) {
            mvc.setViewName("product/modifyPlayManage");
        }else if("academyLectureList".equals(page_gbn)) {
            mvc.setViewName("product/academyLectureList");
        }else if("modifyAcademyLecture".equals(page_gbn)) {
            mvc.setViewName("product/modifyAcademyLecture");
        }else if("bookList".equals(page_gbn)) {
            mvc.setViewName("product/bookList");
        }else if("bookSave".equals(page_gbn)) {
            mvc.setViewName("product/bookSave");
        }else if("modifyBook".equals(page_gbn)) {
            mvc.setViewName("product/modifyBook");
        }else if("academyLectureSave".equals(page_gbn)) {
            mvc.setViewName("product/academyLectureSave");
        }else if("mokExamManage".equals(page_gbn)) {
            mvc.setViewName("product/mokExamManage");
        }else if("mokExamList".equals(page_gbn)) {
            mvc.setViewName("product/mokExamList");
        }else if("modifyMokExam".equals(page_gbn)) {
            mvc.setViewName("product/modifyMokExam");
        }

        return mvc;
    }
}
