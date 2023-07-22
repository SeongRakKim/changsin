package com.ksr.webapp.common.login;

import com.google.gson.JsonObject;
import com.ksr.webapp.common.config.CoTopComponent;
import org.springframework.security.authentication.*;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class TabletAuthFailureHandler extends CoTopComponent implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response
            , AuthenticationException exception) throws IOException, ServletException {

        writeResponse(response, parseException(request.getParameter("id"), exception, request));

    }

    private JsonObject parseException(String userName, AuthenticationException exception, HttpServletRequest request) {
        String errCode = "99";
//        String errMsg = exception.getMessage();
        String errMsg = "";

        if(exception instanceof BadCredentialsException) {
            errMsg = "비밀번호가 일치하지 않습니다.";
        }

        if(exception instanceof InternalAuthenticationServiceException) {
            errMsg = "존재하지 않는 ID입니다.";
        }

        if(exception instanceof AuthenticationCredentialsNotFoundException) {
            errMsg = "인증이 거부되었습니다.";
        }

        if(exception instanceof LockedException) {
            errMsg = "인증이 거부되었습니다 - 잠긴 계정.";
        }

        if(exception instanceof DisabledException) {
            errMsg = "인증이 거부되었습니다 - 계정 비활성화.";
        }

        if(exception instanceof AccountExpiredException) {
            errMsg = "인증이 거부되었습니다 - 계정 유효기간 만료.";
        }

        if(exception instanceof CredentialsExpiredException) {
            errMsg = "인증이 거부되었습니다 - 비밀번호 유효기간 만료.";
        }
        
        JsonObject result = new JsonObject();
        result.addProperty("resultCode", errCode);
        result.addProperty("resultMessage", errMsg);
        return result;
    }
}
