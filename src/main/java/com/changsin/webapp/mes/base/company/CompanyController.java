package com.changsin.webapp.mes.base.company;

import com.changsin.webapp.common.vo.VMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class CompanyController {

    @GetMapping("/mes/base/company/list")
    public void companyList(VMap vmap, Model model, HttpServletRequest httpServletRequest) {
        vmap.put("requestUri", httpServletRequest.getRequestURI());
    }

}
