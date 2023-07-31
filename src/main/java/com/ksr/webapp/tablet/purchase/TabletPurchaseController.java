package com.ksr.webapp.tablet.purchase;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.user.UserService;
import com.ksr.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class TabletPurchaseController {

    @Autowired
    CommonService commonService;

    @Autowired
    UserService userService;


    @RequestMapping("/tablet/purchase/in")
    public void homeGet(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());
    }

}
