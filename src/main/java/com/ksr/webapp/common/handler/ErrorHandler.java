package com.ksr.webapp.common.handler;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;

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
