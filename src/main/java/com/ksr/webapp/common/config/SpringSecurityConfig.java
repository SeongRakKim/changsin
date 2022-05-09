package com.ksr.webapp.common.config;

import com.ksr.webapp.common.login.AuthFailureHandler;
import com.ksr.webapp.common.login.AuthSuccessHandler;
import com.ksr.webapp.common.login.LoginIdPwValidator;
import com.ksr.webapp.mes.base.user.UserService;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
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
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    LoginIdPwValidator loginIdPwValidator;

    @Autowired
    AuthSuccessHandler authSuccessHandler;

    @Autowired
    AuthFailureHandler authFailureHandler;

    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
                .csrf().disable()
                .authorizeHttpRequests()
                .antMatchers(Url.LOGIN).permitAll() //인증 예외
//                .antMatchers("/**").permitAll() //인증 예외
                .anyRequest().authenticated() // 모두 인증
                .and()
                .formLogin()
                .loginPage(Url.LOGIN)
                .loginProcessingUrl(Url.LOGIN_PROC)
                .usernameParameter("id")
                .passwordParameter("password")
                .successHandler(authSuccessHandler)
                .failureHandler(authFailureHandler)
//                .defaultSuccessUrl("/", true)
                .and()
                .logout()
//                .logoutUrl(Url.LOGIN)
//                .invalidateHttpSession(true)
//                .deleteCookies("JSESSIONID")
                .and()
                .sessionManagement()
                .maximumSessions(1)
                .expiredUrl(Url.LOGIN)
                .sessionRegistry(sessionRegistry())
                .maxSessionsPreventsLogin(true)
//                .and()
//                .and().rememberMe()
//                .alwaysRemember(false)
//                .tokenValiditySeconds(43200)
//                .rememberMeParameter("remember-me")
                ;
    }

    @Bean
    public SessionRegistry sessionRegistry() {
        return new SpringSecuritySessionRegistImpl();
    }

    @Bean
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
