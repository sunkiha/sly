package config;

import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.ext.plugin.tablebind.AutoTableBindPlugin;
import com.jfinal.ext.route.AutoBindRoutes;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.render.ViewType;

import controller.index.IndexController;

/**
 * API引导式配置
 */
public class JfinalConfig extends JFinalConfig {
	
	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		loadPropertyFile("a_little_config.txt");				// 加载少量必要配置，随后可用getProperty(...)获取值
		me.setDevMode(getPropertyToBoolean("devMode", false));
		me.setViewType(ViewType.JSP); 	
		me.setBaseViewPath("view/");
		me.setError500View("../error.jsp");
		me.setError404View("../error.jsp");
		// 设置视图类型为Jsp，否则默认为FreeMarker
	}
	
	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		me.add("/", IndexController.class,"/index");
		me.add(new AutoBindRoutes());
			// 第三个参数为该Controller的视图存放路径
		//me.add("/blog", BlogController.class);			// 第三个参数省略时默认与第一个参数值相同，在此即为 "/blog"
	}
	
	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		// 配置C3p0数据库连接池插件
	/*   C3p0Plugin c3p0Plugin = new C3p0Plugin(getProperty("jdbcUrl"), getProperty("user"), getProperty("password").trim());
		me.add(c3p0Plugin);*/
		
		// 配置ActiveRecord插件
	/*	ActiveRecordPlugin arp = new ActiveRecordPlugin(c3p0Plugin);
		me.add(arp);*/
		DruidPlugin druid = new DruidPlugin(getProperty("jdbcUrl"), getProperty("user"), getProperty("password").trim());
		AutoTableBindPlugin atbp = new AutoTableBindPlugin(druid);
		atbp.setShowSql(true);
		me.add(druid);
		me.add(atbp);
		//arp.addMapping("blog", Blog.class);	// 映射blog 表到 Blog模型
	}
	
	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		
	}
	
	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
		
	}
	
	/**
	 * 建议使用 JFinal 手册推荐的方式启动项目
	 * 运行此 main 方法可以启动项目，此main方法可以放置在任意的Class类定义中，不一定要放于此
	 */
	public static void main(String[] args) {
		//JFinal.start("WebContent", 82, "/", 5);
		for (int i = 0; i <=50; i++) {
			System.out.println("<option value='"+i+"'>第"+i+"周</option>");
		}
	}
}
