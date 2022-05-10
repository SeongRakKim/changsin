package com.ksr.webapp.common.resolver;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.util.DateUtils;
import com.ksr.webapp.common.vo.VMap;
import lombok.RequiredArgsConstructor;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RequiredArgsConstructor
@Component
public class MapArgumentResolver implements HandlerMethodArgumentResolver {

    @Override
    public boolean supportsParameter(MethodParameter methodParameter) {
        return VMap.class.isAssignableFrom(methodParameter.getParameterType());
    }

    @Override
    public Object resolveArgument(MethodParameter methodParameter, ModelAndViewContainer modelAndViewContainer,
                                  NativeWebRequest nativeWebRequest, WebDataBinderFactory webDataBinderFactory) throws Exception {
        Class<?> clazz = methodParameter.getParameterType();
        String paramName = methodParameter.getParameterName();

        if (clazz != null && clazz.equals(VMap.class) && paramName != null && paramName.equals("vmap")) {
            HttpServletRequest request = (HttpServletRequest) nativeWebRequest.getNativeRequest();
            VMap vmap = new VMap(request);

            HttpSession session = request.getSession();

            vmap.put("fact_cd", "1000");
            vmap.put("today", DateUtils.getTodayDate());
            vmap.put("todayTime", DateUtils.getTodayTime());
            vmap.put("startDate", vmap.getString("startDate", DateUtils.getDate("yyyy-MM-dd", -7)));
            vmap.put("endDate", vmap.getString("endDate", DateUtils.getToday("yyyy-MM-dd")));
            vmap.put("lastDate", DateUtils.getLastDate(Integer.parseInt(DateUtils.getToday("yyyy")), Integer.parseInt(DateUtils.getToday("MM"))));
            vmap.put("u_cd", vmap.get(""));
            if(CommonUtils.isNotEmpty(session.getAttribute("u_cd"))) {
                vmap.put("u_cd", session.getAttribute("u_cd"));
            }

            request.setAttribute("vmap", vmap.getMap());
            return vmap;
        }

        return new Object();
    }

}
