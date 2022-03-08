package com.ysis.webapp.mes.base.equipment;

import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.base.process.ProcessService;
import com.ysis.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class EquipmentController {

    @Autowired CommonService commonService;
    @Autowired
    ProcessService processService;

    @GetMapping("/mes/base/equipment/list")
    public void equipmentList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        vmap.put("processList", processService.procList(vmap));
    }

}
