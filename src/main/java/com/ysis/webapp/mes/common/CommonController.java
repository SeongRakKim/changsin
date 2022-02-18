package com.ysis.webapp.mes.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommonController {

    @GetMapping("/")
    public String index() throws Exception {
        return "index";
    }


}
