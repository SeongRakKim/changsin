package com.changsin;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "com.changsin.webapp.mes")
public class ChangsinApplication {

	public static void main(String[] args) {
		SpringApplication.run(ChangsinApplication.class, args);
	}

}
