package com.ksr.webapp.mes.base.user;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserRestController {

    @GetMapping("/mes/base/user/getUserList")
    public String getUserList() {
        return "이제 시작하는 것이야아아아~~~";
    }

}
