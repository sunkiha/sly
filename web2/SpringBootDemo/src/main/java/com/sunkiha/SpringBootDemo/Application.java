package com.sunkiha.SpringBootDemo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
/*@SpringBootApplication注解等价于以默认属性使用
@Configuration，@EnableAutoConfiguration和@ComponentScan：*/
@SpringBootApplication
@MapperScan("com.sunkiha.SpringBootDemo.domain")
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
}
