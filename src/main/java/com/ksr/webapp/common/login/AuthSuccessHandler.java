package com.ksr.webapp.common.login;

import com.google.gson.JsonObject;
import com.ksr.webapp.common.config.CoTopComponent;
import com.ksr.webapp.common.config.Url;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.user.CustomUserDetails;
import lombok.extern.slf4j.Slf4j;
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

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Slf4j
@Component
public class AuthSuccessHandler extends CoTopComponent implements AuthenticationSuccessHandler {

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

        writeResponse(response, loginResult);

//        HttpServletRequest request2 = (HttpServletRequest) nativeWebRequest.getNativeRequest();
//        response.sendRedirect("/");

    }
}

