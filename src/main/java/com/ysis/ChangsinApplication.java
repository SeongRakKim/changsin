package com.ysis;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ChangsinApplication  {

	public static void main(String[] args) {
		SpringApplication.run(ChangsinApplication.class, args);
	}

//	@Bean
//	public FilterRegistrationBean encodingFilterBean() {
//		FilterRegistrationBean registrationBean = new FilterRegistrationBean();
//		CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
//		characterEncodingFilter.setForceEncoding(true);
//		characterEncodingFilter.setEncoding("UTF-8");
//		registrationBean.setFilter(characterEncodingFilter);
//		return registrationBean;
//	}

}