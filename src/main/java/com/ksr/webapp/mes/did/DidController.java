package com.ksr.webapp.mes.did;

import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class DidController {

    @GetMapping("/did")
    public String didIndex(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        return "/did/notice/list";
    }

    @GetMapping("/did/notice/list")
    public void didNotice(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {

    }


}
