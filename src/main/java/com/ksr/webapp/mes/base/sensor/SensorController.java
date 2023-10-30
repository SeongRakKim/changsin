package com.ksr.webapp.mes.base.sensor;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.process.ProcessService;
import com.ksr.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class SensorController {

    @Autowired CommonService commonService;
    @Autowired
    ProcessService processService;

    @GetMapping("/mes/base/sensor/list")
    public void equipmentList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());
    }

}
