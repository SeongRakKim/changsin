package com.ksr.webapp.mes.report;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ReportController {

    @Autowired CommonService commonService;

    @GetMapping("/mes/report/production/list")
    public void reportProductionList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());
    }

    @GetMapping("/mes/report/shipment/list")
    public void reportShipmentList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());
    }

    @GetMapping("/mes/report/product/list")
    public void reportProductList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());
    }

    @GetMapping("/mes/report/material/list")
    public void reportMaterialList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());
    }

}
