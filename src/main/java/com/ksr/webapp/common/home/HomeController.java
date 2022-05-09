package com.ksr.webapp.common.home;

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

import javax.servlet.http.HttpServletRequest;

@Controller
public class HomeController {

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


    @GetMapping("/")
    public String homeGet(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
//        vmap.put("requestUri", httpServletRequest.getRequestURI());

        System.out.println("!111111!!!!!=========================");

        return "index";
    }


}
