package com.ksr.webapp.common.login;

import com.google.gson.JsonObject;
import com.ksr.webapp.common.config.BaseCodeItem;
import com.ksr.webapp.common.config.CoTopComponent;
import com.ksr.webapp.common.retrofit.RetrofitService;
import com.ksr.webapp.common.util.ClientUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.user.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Slf4j
@Component
public class TabletAuthSuccessHandler extends CoTopComponent implements AuthenticationSuccessHandler {

    @Autowired
    UserService userService;

    @Autowired
    RetrofitService retrofitService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response
            , Authentication authentication) throws IOException, ServletException {

        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(60 * 60 * 3);
        session.setAttribute("userInfo", authentication.getPrincipal());
        session.setAttribute("u_cd", authentication.getName());

        JsonObject loginResult = new JsonObject();
        loginResult.addProperty("resultCode", "00");
        loginResult.addProperty("targetUrl", request.getContextPath() + "/common/tablet/menu/list");

        writeResponse(response, loginResult);
    }
}

