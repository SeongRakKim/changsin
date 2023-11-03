package com.ksr.webapp.mes.base.tool;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.department.DepartmentQueryRepository;
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
public class ToolController {

    @Autowired CommonService commonService;
    @Autowired
    ProcessService processService;
    @Autowired
    ProductService productService;
    private final DepartmentQueryRepository departmentQueryRepository;

    @GetMapping("/mes/base/tool/list")
    public void equipmentList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());
        vmap.put("productList", productService.prodList(vmap));
        vmap.put("deptList", departmentQueryRepository.deptList(vmap));
    }

}
