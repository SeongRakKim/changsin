package com.ksr.webapp.tablet.production;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.equipment.EquipmentService;
import com.ksr.webapp.mes.base.material.MaterialService;
import com.ksr.webapp.mes.base.user.UserService;
import com.ksr.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class TabletProductionController {

    @Autowired
    CommonService commonService;

    @Autowired
    UserService userService;

    @Autowired
    EquipmentService equipmentService;

    @Autowired
    MaterialService materialService;

    @RequestMapping("/tablet/production/list")
    public void list(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());
    }

    @RequestMapping("/tablet/production/result")
    public void result(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        // 설비
        vmap.put("equList", equipmentService.equList(vmap));

        // 사용자
        vmap.put("userList", userService.userList(vmap));

        // 소요자재
        vmap.put("mateList", materialService.mateList(vmap));

        // 비가동구분
        vmap.put("base_cd", "plan_stop_item");
        vmap.put("stopList", commonService.baseDetailList(vmap));
    }
}
