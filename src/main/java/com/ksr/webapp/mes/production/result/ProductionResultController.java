package com.ksr.webapp.mes.production.result;

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
public class ProductionResultController {

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


    @GetMapping("/mes/production/result/list")
    public void planList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
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

        // 공정
        vmap.put("procList", processService.procList(vmap));

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
