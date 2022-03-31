package com.ksr.webapp.common.config;

import com.ksr.webapp.common.resolver.MapArgumentResolver;
import com.ksr.webapp.common.resolver.MyArgumentResolver;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.List;

@Configuration
//@EnableWebMvc
//@ComponentScan(basePackages = {"com.changsin.webapp"})
public class WebMvcConfig implements WebMvcConfigurer {

//    @Override
//    public void addViewControllers(ViewControllerRegistry registry) {
//        registry.addViewController("/**").setViewName("aaa");
//    }

    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
        resolvers.add(new MapArgumentResolver());
        resolvers.add(new MyArgumentResolver());
    }
}
