package com.sunkiha.SpringBootDemo.domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


public interface UserMapper {

    public ArrayList findAll();
		
}
