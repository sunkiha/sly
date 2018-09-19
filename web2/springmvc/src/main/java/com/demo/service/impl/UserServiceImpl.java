package com.demo.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.demo.dao.UserDAO;
import com.demo.model.User;
import com.demo.service.UserService;
 
 
 
@Service
public class UserServiceImpl implements UserService{
 
    @Autowired
    @Qualifier("userDAO")
    private UserDAO userDAO;
     
    public int insertUser(User user) {
        // TODO Auto-generated method stub
        return userDAO.insertUser(user);
    }
 
}