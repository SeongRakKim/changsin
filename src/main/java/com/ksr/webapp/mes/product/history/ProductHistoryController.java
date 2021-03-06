package com.ksr.webapp.mes.product.history;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.material.MaterialService;
import com.ksr.webapp.mes.base.process.ProcessService;
import com.ksr.webapp.mes.base.product.ProductService;
import com.ksr.webapp.mes.common.CommonService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequiredArgsConstructor
public class ProductHistoryController {

    private final CommonService commonService;
    private final ProcessService processService;
    private final MaterialService materialService;
    private final ProductService productService;

    @GetMapping("/mes/product/history/list")
    public void productList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
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

        // 제품
        vmap.put("prod_cls", "P");
        vmap.put("prodList", productService.prodList(vmap));

    }

}
