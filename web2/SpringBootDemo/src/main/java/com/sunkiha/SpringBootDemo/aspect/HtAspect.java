package com.sunkiha.SpringBootDemo.aspect;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class HtAspect {
	@Before("execution (public * com.sunkiha.SpringBootDemo.web.FreemarkerController.*(..))")
	public void log() {
		System.out.println("q1111111111111111");
	}
}
