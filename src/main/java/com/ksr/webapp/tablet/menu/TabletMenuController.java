package com.ksr.webapp.tablet.menu;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.equipment.EquipmentService;
import com.ksr.webapp.mes.base.material.MaterialService;
import com.ksr.webapp.mes.base.process.ProcessService;
import com.ksr.webapp.mes.base.user.UserService;
import com.ksr.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class TabletMenuController {

    @Autowired
    CommonService commonService;

    @Autowired
    UserService userService;


    @RequestMapping("/common/tablet/menu/list")
    public String homeGet(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        return "/common/tablet/menu/list";
    }

    @RequestMapping("/common/tablet/process/list")
    public String homeGet2(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        return "/common/tablet/process/list";
    }

}
