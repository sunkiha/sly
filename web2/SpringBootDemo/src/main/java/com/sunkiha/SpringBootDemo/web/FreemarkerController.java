package com.sunkiha.SpringBootDemo.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sunkiha.SpringBootDemo.domain.UserMapper;
import com.sunkiha.SpringBootDemo.service.UserService;

@Controller
@RequestMapping("freemarker")
public class FreemarkerController {
	@Autowired
	UserService userService;

	@RequestMapping("hello")
	// @ResponseBody
	public String hello(Map<String, Object> map) throws Exception {
		userService.findAll();
		map.put("msg", "首页 ");//
		/*
		 * if(1==1) { throw new Exception(); }
		 */
		// return userService.findAll();
		return "index/index";
	}

	@RequestMapping("hello2")
	@ResponseBody
	public List  hello2(Map<String, Object> map) throws Exception {
		userService.findAll();
		map.put("msg", "首页 ");
		/*
		 * if(1==1) { throw new Exception(); }
		 */
		return userService.findAll();
	}
}
