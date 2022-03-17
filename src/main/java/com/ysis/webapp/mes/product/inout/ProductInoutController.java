package com.ysis.webapp.mes.product.inout;

import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.base.equipment.EquipmentService;
import com.ysis.webapp.mes.base.material.MaterialService;
import com.ysis.webapp.mes.base.process.ProcessService;
import com.ysis.webapp.mes.base.user.UserService;
import com.ysis.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ProductInoutController {

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


    @GetMapping("/mes/product/inout/list")
    public void productInoutList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
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
    }

}
