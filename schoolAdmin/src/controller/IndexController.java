package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.generator.Generator;
import com.jfinal.plugin.activerecord.generator.MetaBuilder;
import com.jfinal.plugin.activerecord.generator.TableMeta;

import comm.BaseController;
import comm.Mail;
import freemarker.template.Configuration;
import freemarker.template.Template;

public class IndexController extends BaseController {
	public void index() {
		//MailKit.send("2771161998@qq.com",null, "邮件标题", "邮件内容");
		//Mail ds = new Mail();  
	      //  ds.sendMail("450273594@qq.com", "验证码2344", "注册验证码");  
		render("login.jsp");
	}

	public void create() {

		try

		/*
		 * MetaBuilder b=new MetaBuilder(DbKit.getConfig().getDataSource()); for
		 * (TableMeta a : b.build()) { //System.out.println(a.); }
		 */
		{

			String tmpUrl = "E:\\eclipsespace\\pubAdmin\\";
			Configuration cfg = new Configuration();
			cfg.setDirectoryForTemplateLoading(new File(tmpUrl));
			createController(cfg);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String upperCase(String str) {
		char[] ch = str.toCharArray();
		if (ch[0] >= 'a' && ch[0] <= 'z') {
			ch[0] = (char) (ch[0] - 32);
		}
		return new String(ch);
	}

	void createController(Configuration cfg) {
		try {

			String savePath = "E:\\eclipsespace\\pubAdmin\\src\\controller";
			File newsDir = new File(savePath);
			boolean flag = (Boolean) (newsDir.exists() == false ? newsDir.mkdirs() : newsDir.delete());
			Template controllerTemp = cfg.getTemplate("controller.ftl", "utf-8");
			List<String> tables = Db.query("show TABLES");
			for (String string : tables) {
				Map<String, String> param = new HashMap<>();
				string = upperCase(string);
				param.put("tabelName", string);
				Writer out = new OutputStreamWriter(new FileOutputStream(savePath + "/" + string + "Controller.java"),
						"utf-8");
				controllerTemp.process(param, out);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
