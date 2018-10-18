package com.sunkiha.SpringBootDemo.service;

import java.util.ArrayList;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sunkiha.SpringBootDemo.domain.UserMapper;
@Service
public class UserService {

	@Autowired
	UserMapper userMapper;

	public ArrayList findAll() {
		return userMapper.findAll();
	}
}
