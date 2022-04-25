package com.ksr.webapp.mes.quality;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class QualityController {

    @Autowired CommonService commonService;

    @GetMapping("/mes/quality/material/list")
    public void qualityMaterialList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        vmap.put("base_cd", "quality_item");
        vmap.put("qualityItemList", commonService.baseDetailList(vmap));
    }

    @GetMapping("/mes/quality/process/list")
    public void qualityProcessList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        vmap.put("base_cd", "quality_item");
        vmap.put("qualityItemList", commonService.baseDetailList(vmap));
    }

    @GetMapping("/mes/quality/shipment/list")
    public void qualityShipmentList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        vmap.put("base_cd", "quality_item");
        vmap.put("qualityItemList", commonService.baseDetailList(vmap));
    }

}
