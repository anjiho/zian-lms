package com.zianedu.lms.controller;

import com.zianedu.lms.utils.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestController {

    @RequestMapping(value={"/test"})
    public ModelAndView test(@RequestParam(value="page_gbn", required=false)String page_gbn) {
        ModelAndView mvc = new ModelAndView();
        if("".equals(Util.isNullValue(page_gbn, ""))) {
            mvc.setViewName("test/test");
        }
        return mvc;
    }
}
