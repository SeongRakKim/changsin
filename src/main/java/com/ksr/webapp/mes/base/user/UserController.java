package com.ksr.webapp.mes.base.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
public class UserController {

    @RequestMapping(value = "/mes/base/user/list")
    public ModelAndView list() throws Exception {
        ModelAndView mav = new ModelAndView("/mes/base/user/list");
        mav.addObject("name", "goddaehee");
        List<String> testList = new ArrayList<String>();
        testList.add("a");
        testList.add("b");
        testList.add("c");
        mav.addObject("list", testList);
        return mav;
    }


}
