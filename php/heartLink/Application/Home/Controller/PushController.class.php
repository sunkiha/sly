<?php
namespace Home\Controller;
use Think\Controller;
class PushController extends Controller {
    public function index(){
      // echo strlen("4ed12ca56bc64b5995d77fef6ec9a196");
      // $this->show('<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} body{ background: #fff; font-family: "微软雅黑"; color: #333;font-size:24px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.8em; font-size: 36px }</style><div style="padding: 24px 48px;"> <h1>:)</h1><p>欢迎使用 <b>ThinkPHP</b>！</p><br/>[ 您现在访问的是Home模块的Index控制器 ]</div><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script>','utf-8');
    }
   public  function a(){
   	$god= M("god");
   	$god->id="sd";
   	$god->add();
    	echo "sd";
    }
    public function get(){
    	//或者使用M快捷方法是等效的
			$d = M();
			$a=I("id");
			//进行原生的SQL查询
			$f=$d->query("select * from god");
			$s=array(
			"sd"=>3
			);
    	$this->ajaxReturn($f);
    }
    public function push(){
    
    }
}