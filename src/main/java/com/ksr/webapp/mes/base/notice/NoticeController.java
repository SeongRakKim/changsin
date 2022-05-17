package com.ksr.webapp.mes.base.notice;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class NoticeController {

    @Autowired CommonService commonService;

    @GetMapping("/mes/base/notice/list")
    public void noticeList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());
    }

}
