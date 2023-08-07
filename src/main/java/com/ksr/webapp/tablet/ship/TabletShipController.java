package com.ksr.webapp.tablet.ship;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.user.UserService;
import com.ksr.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class TabletShipController {

    @Autowired
    CommonService commonService;

    @Autowired
    UserService userService;


    @RequestMapping("/tablet/ship/out")
    public void homeGet(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());
    }

    @RequestMapping("/tablet/ship/result")
    public void result(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        // 분류
        vmap.put("base_cd", "prod_group");
        vmap.put("prodGroupList", commonService.baseDetailList(vmap));

        // 제품군
        vmap.put("base_cd", "prod_family");
        vmap.put("prodFamilyList", commonService.baseDetailList(vmap));

        // 단위
        vmap.put("base_cd", "unit");
        vmap.put("unitList", commonService.baseDetailList(vmap));

        // 사용자
        vmap.put("userList", userService.userList(vmap));
    }

}
