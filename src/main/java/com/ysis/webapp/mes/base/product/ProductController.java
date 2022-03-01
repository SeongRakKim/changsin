package com.ysis.webapp.mes.base.product;

import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ProductController {

    @Autowired CommonService commonService;

    @GetMapping("/mes/base/product/list")
    public void companyList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        vmap.put("base_cd", "comp_group");
        vmap.put("compGroupList", commonService.baseDetailList(vmap));

        vmap.put("base_cd", "comp_type");
        vmap.put("compTypeList", commonService.baseDetailList(vmap));
    }

}
