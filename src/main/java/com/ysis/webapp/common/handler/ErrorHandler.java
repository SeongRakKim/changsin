package com.ysis.webapp.common.handler;

import com.ysis.webapp.common.util.CommonUtils;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

@Controller
public class ErrorHandler implements ErrorController {

//    @Override
//    public String getErrorPath() {
//        return null;
//    }

//    @GetMapping("/error")
//    public String errorHandler(HttpServletRequest httpServletRequest) {
//        Object status = httpServletRequest.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
//
//        if(CommonUtils.isNotEmpty(status)) {
//            int statusCode = Integer.valueOf(status.toString());
//
//            if(statusCode == HttpStatus.NOT_FOUND.value()) {
//                return "/error/404";
//            }else {
//                return "/error/404";
//            }
//        }
//
//        return "/error/404";
//    }

}
