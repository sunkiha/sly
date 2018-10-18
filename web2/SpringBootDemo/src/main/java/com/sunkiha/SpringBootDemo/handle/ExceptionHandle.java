package com.sunkiha.SpringBootDemo.handle;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class ExceptionHandle {
	@ExceptionHandler(value = Exception.class)
	@ResponseBody
	public String handle(Exception e) {
		System.out.println("sd");
		return e.getMessage();
	}
}
