package com.ksr.webapp.common.config;

import com.ksr.webapp.common.handler.SimpleUrlLogoutSuccessHandler;
import com.ksr.webapp.common.login.AuthFailureHandler;
import com.ksr.webapp.common.login.AuthSuccessHandler;
import com.ksr.webapp.common.login.LoginIdPwValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
@Order(1)
public class SpringSecurityConfig1 extends WebSecurityConfigurerAdapter {

    @Autowired
    LoginIdPwValidator loginIdPwValidator;

    @Autowired
    AuthSuccessHandler authSuccessHandler;

    @Autowired
    AuthFailureHandler authFailureHandler;

    @Autowired
    SimpleUrlLogoutSuccessHandler simpleUrlLogoutSuccessHandler;

    @Override
    protected void configure(HttpSecurity http) throws Exception
    {

        http
            .antMatcher("/tablet/**")
            .csrf().disable()
        ;

        http
            .authorizeHttpRequests()
            .antMatchers(Url.TABLET_LOGIN, Url.DID_PATH).permitAll()
            .anyRequest().authenticated() // 모두 인증
        ;

        http
            .formLogin()
            .loginPage(Url.TABLET_LOGIN)
            .loginProcessingUrl(Url.LOGIN_PROC)
            .usernameParameter("id")
            .passwordParameter("password")
            .successHandler(authSuccessHandler)
            .failureHandler(authFailureHandler)
        ;

        http
            .logout()
            .invalidateHttpSession(true)
            .deleteCookies("JSESSIONID")
            .logoutSuccessHandler(simpleUrlLogoutSuccessHandler)
//            .logoutSuccessHandler(((request, response, authentication) -> {
//                response.sendRedirect("/login/form");
//            }))
        ;

        http
            .sessionManagement()
            .maximumSessions(-1)
            .expiredUrl(Url.TABLET_LOGIN)
            .sessionRegistry(sessionRegistry())
            .maxSessionsPreventsLogin(true)
        ;

        http
            .rememberMe()
            .alwaysRemember(false)
            .tokenValiditySeconds(43200)
            .rememberMeParameter("remember-me")
        ;

    }

    @Bean("sessionRegistry")
    public SessionRegistry sessionRegistry() {
        return new SpringSecuritySessionRegistImpl();
    }

    @Bean("passwordEncoder")
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    public void configure(WebSecurity webSecurity) throws Exception {
        webSecurity.ignoring().antMatchers(Constants.STATIOC_RESOUCREC_URL_PATTERNS);
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(loginIdPwValidator).passwordEncoder(new BCryptPasswordEncoder());
    }

}