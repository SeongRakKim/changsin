package com.ksr.webapp.tablet.quality;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.user.UserService;
import com.ksr.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class TabletQualityController {

    @Autowired
    CommonService commonService;

    @Autowired
    UserService userService;


    @RequestMapping("/tablet/quality/material/list")
    public void homeGet(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        vmap.put("base_cd", "quality_item");
        vmap.put("qualityItemList", commonService.baseDetailList(vmap));
    }

    @RequestMapping("/tablet/quality/list")
    public void homeGet4(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        vmap.put("base_cd", "quality_item");
        vmap.put("qualityItemList", commonService.baseDetailList(vmap));
    }

    @RequestMapping("/tablet/quality/process/list")
    public void homeGet2(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        vmap.put("base_cd", "quality_item");
        vmap.put("qualityItemList", commonService.baseDetailList(vmap));
    }

    @RequestMapping("/tablet/quality/shipment/list")
    public void homeGet3(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        vmap.put("base_cd", "quality_item");
        vmap.put("qualityItemList", commonService.baseDetailList(vmap));
    }

}
