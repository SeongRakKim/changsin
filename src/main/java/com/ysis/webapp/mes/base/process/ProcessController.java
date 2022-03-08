package com.ysis.webapp.mes.base.process;

import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ProcessController {

    @Autowired CommonService commonService;

    @GetMapping("/mes/base/process/list")
    public void processList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

    }

}
