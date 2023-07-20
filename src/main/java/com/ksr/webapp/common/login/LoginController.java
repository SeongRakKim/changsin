package com.ksr.webapp.common.login;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.equipment.EquipmentService;
import com.ksr.webapp.mes.base.material.MaterialService;
import com.ksr.webapp.mes.base.process.ProcessService;
import com.ksr.webapp.mes.base.user.UserService;
import com.ksr.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController {

    @Autowired
    CommonService commonService;

    @Autowired
    ProcessService processService;

    @Autowired
    MaterialService materialService;

    @Autowired
    EquipmentService equipmentService;

    @Autowired
    UserService userService;


    @RequestMapping("/login/form")
    public String homeGet(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        return "/common/login/form";
    }

    @RequestMapping("/tablet/login/form")
    public String tabletHomeGet(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        return "/common/tablet/login/form";
    }

    @GetMapping("/tablet")
    public String tabletGet(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        return "redirect:/did/notice/list";
    }

}
