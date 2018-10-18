package com.sunkiha.SpringBootDemo.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {
    @RequestMapping("/hello")
    public Map index() {
    	Map m=new HashMap();
    	m.put("sd", "sads");
        return m;
    }
}
