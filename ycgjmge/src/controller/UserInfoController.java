package controller;

import com.alibaba.fastjson.JSONObject;

import comm.BaseController;
import comm.S;

public class UserInfoController extends BaseController{
	public void login(){
		JSONObject rm=new JSONObject();
		rm.put(S.code, 1);
		rm.put(S.msg, "登录成功");
		renderJson(rm);
	}
}
