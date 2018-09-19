<?php
namespace Home\Controller;
use Think\Controller;
class GodController extends Controller {
	public function register(){
		//$id,$username,$password,$sex,$email
		$god=M("god");
		$god->id=uuid();
		$god->username=I("username");
		$god->password=I("password");
		$god->sex=I("sex");
		$god->email=I("email");
		$god->createdate=date("Y-m-d h:m:s");  
		$n=$god->add();
		if($n){
		 $map=array(
		  "status"=>0,
		  "msg"=>"注册成功"
		 );
		 
		}else{
		 $map=array(
		  "status"=>1,
		  "msg"=>"注册失败"
		 );
		}
		$this->ajaxReturn($map);
	}
	public function login(){
		$god=M("god");
		try {
	     $map['username'] =array('eq', I('username'));
	     $map['password'] =array('eq',I('password'));
	   //  $g=$god->where("username=".I('username')." and password=".md5(I('password')))->find();//只返回一条数据
	     $g=$god->field("id,username,head")->where($map)->find();//只返回一条数据
	    session("god",$g);
	     if($g){
	     	$msg="登录成功";
	     	
	     }else{
	     	$msg="用户名或密码不正确";
	     }
	     $map=array(
		  "status"=>0,
		  "msg"=>$msg,
		  "user"=>$g,
		  "sid"=>session_id()
		 );
	    $this->ajaxReturn($map);
	   }catch( Exception $e ) {
	   	$msg="数据库异常";
	   	if(I("print")==1)
	   	 $msg.=$e;
		 $map=array(
		  "status"=>1,
		  "msg"=>$msg,
		  "user"=>$g
		 );
	     $this->ajaxReturn($map);
	  }
		
	}
	public function socket(){
		//报错级别
		error_reporting(E_ALL);
		//设置长链接
		set_time_limit(0);
		//ip
		 
		$address = "127.0.0.1";
		//端口
		 
		$port = 8080;
		 
		//创建一个套接字
		 
		if( ($sock = socket_create(AF_INET, SOCK_STREAM, SOL_TCP)) ===false){
		 
		echo "创建一个套接字 失败" . "\n";
		 
		}
		 
		//启动套接字
		 
		if(socket_bind($sock, $address,$port)===false){
		 
		echo "启动套接字 失败" . socket_strerror(socket_last_error($sock)) . "\n"; 
		
		}
		 
		
		//监听端口
		 
		if(socket_listen($sock,5) === false){
		 
		echo "监听端口 失败" . socket_strerror(socket_last_error($sock)) . "\n";
		 
		}
		 
		
		do {
		 
		//似乎是接收客户端传来的消息
		 
		if(($msgsock=socket_accept($sock))===false){
		 
		echo "socket_accepty() failed :reason:".socket_strerror(socket_last_error($sock)) . "\n";
		 
		break; 
		
		}
		 
		//echo "读取客户端传来的消息"."\n";
		 
		$buf = socket_read($msgsock, 8192);
		 
		$talkback = "我已经成功接到客户端的信息了。现在我还回信息给客户端"."\n";
		 
		if(false=== socket_write($msgsock, $talkback)){
		 
		echo "socket_write() failed reason:" . socket_strerror(socket_last_error($sock)) ."\n";
		 
		}else{
		 
		echo "return info msg ku fu duan success"."\n";
		 
		}
		 
		socket_close($msgsock);
		 
		}while (true);
		 
		socket_close($sock);
		 
	}
}
?>