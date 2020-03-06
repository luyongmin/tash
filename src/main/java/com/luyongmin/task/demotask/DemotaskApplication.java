package com.luyongmin.task.demotask;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class DemotaskApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemotaskApplication.class, args);
	}

}
