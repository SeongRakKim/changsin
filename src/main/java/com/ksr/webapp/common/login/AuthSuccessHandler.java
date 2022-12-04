package com.ksr.webapp.common.login;

import com.google.gson.JsonObject;
import com.ksr.webapp.common.config.BaseCodeItem;
import com.ksr.webapp.common.config.CoTopComponent;
import com.ksr.webapp.common.config.Url;
import com.ksr.webapp.common.util.ClientUtils;
import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.user.CustomUserDetails;
import com.ksr.webapp.mes.base.user.UserService;
import com.sun.net.httpserver.HttpServer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.parameters.P;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Slf4j
@Component
public class AuthSuccessHandler extends CoTopComponent implements AuthenticationSuccessHandler {

    @Autowired
    UserService userService;

//    @AuthenticationPrincipal CustomUserDetails customUserDetails;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response
            , Authentication authentication) throws IOException, ServletException {

        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(60 * 60 * 3);
        session.setAttribute("userInfo", authentication.getPrincipal());
        session.setAttribute("u_cd", authentication.getName());

        JsonObject loginResult = new JsonObject();
        loginResult.addProperty("resultCode", "00");
        loginResult.addProperty("targetUrl", request.getContextPath() + "/");

        VMap apiMap = new VMap();
        apiMap.put("api_key", BaseCodeItem.API_KEY);
        apiMap.put("u_cd", authentication.getName());
        apiMap.put("log_type", "접속");
        apiMap.put("log_dt", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(new Date()));

        writeResponse(response, loginResult);

//        HttpServletRequest request2 = (HttpServletRequest) nativeWebRequest.getNativeRequest();
//        response.sendRedirect("/");

    }
}

