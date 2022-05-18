package com.ksr.webapp.mes.did;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class DidController {

    @GetMapping("/did")
    public String didIndex(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        return "redirect:/did/notice/list";
    }

    @GetMapping("/did/notice/list")
    public void didNotice(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {

        if(CommonUtils.isEmpty(vmap.getString("offset"))) {
            vmap.put("offset", 0);
        }
    }

    @GetMapping("/did/production/list")
    public void didProduction(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
    }

    @GetMapping("/did/equipment/list")
    public void didEquipment(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
    }

    @GetMapping("/did/notice/list2")
    public void ttt(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
    }

}
