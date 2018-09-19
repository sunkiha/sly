<?php
namespace Home\Controller;
use Think\Controller;
class MessageController extends Controller {
	public function message(){
		//$id,$username,$password,$sex,$email
		$message=M("message");
		//import('ORG.Util.Page');//导入分页类
		/*$count=$message->count();
		$page=new Page($count,25);*/
		try {
			//$list=$message->where('level=0')->order('createdate')->page($_GET['page'].',3')->select();
			 $map=array(
			  "status"=>0,
			  "msg"=>"成功",
			  "list"=>$list
			 );
			 $this->ajaxReturn($map);
		}
		catch( Exception $e ) {
		  $map=array(
		  "status"=>2,
		  "msg"=>"失败".$e
		 );
		 $this->ajaxReturn($map);
		}
		
		
	}
	public function cry(){
	/*	$id=I("id");
		$mes=M('message');
		$map['id']=$id;
		$rs=$mes->field('cry')->where($map)->find();
		$data['id']=$id;
		$data['cry']=$rs['cry']+1;
		$mes->save($data);*/
		 $map=array(
			  "status"=>0,
			  "msg"=>"成功"
			 );
		$this->ajaxReturn($map);
	}
	public function smile(){
		$id=I("id");
		$mes=M("message");
		$map['id']=array("eq",$id);
		$rs=$mes->field("smile")->where($map)->find();
		$data['id']=$id;
		$data['smile']=$rs['smile']+1;
		$mes->save($data);
		$map=array(
			  "status"=>0,
			  "msg"=>"成功"
			 );
		$this->ajaxReturn($map);
	}
	/**
	 * 投稿
	 */
	public function push($id,$content=""){
		//$s= new \Org\Util\String;
		//$s->uuid();
		 $photoName=uuid();
	     $target_path  = "./Application/Common/photo/";//接收文件目录   
	    	if(!file_exists($target_path)){
		     mkdir($target_path);
		    }
		 
	      $target_path = $target_path. $photoName.'.png'; 
	      if($_FILES['uploadedfile']['tmp_name']){
		      if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_path)) {
		    
		       }else{     
		       	$map=array(
				  "status"=>1,
				  "msg"=>"图片上传失败",
				 );
				  $this->ajaxReturn($map);    
		       }
			
			}
		//$god=session("god");
		$god=M("god");
		$map['id']=array("eq",$id);
		$god=$god->where($map)->find();
		$mes=M("message");
		$mes->id=uuid();
		$mes->godId=$god['id'];
		$mes->godName=$god['username'];
		$mes->head=$god['head'];
		$mes->content=$content;
		$mes->photo= $photoName.'.png';
		$n=$mes->add();
		if($n){
			  $map=array(
			  "status"=>0,
			  "msg"=>"成功",
			 );
		}else{
		 $map=array(
		  "status"=>1,
		  "msg"=>"失败"
		 );
		}
		 $this->ajaxReturn($map);
	}
	public function mesById(){
		$id=I('id');
		$mes=M("message");
		$map['id']=$id;
		$rs=$mes->where($map)->find();
		 $map=array(
			  "status"=>0,
			  "msg"=>"成功",
			  "rs"=>$rs
			 );
		$this->ajaxReturn($map);
	}
	public function remessage(){
		$mesId=I("mesId");
		$godId=I("godId");
		$godName=I("godName");
		$head=I("head");
		$content=I("content");
		$id=uuid();
		$remes=M("remessage");
		$remes->id=$id;
		$remes->content=$content;
		$remes->messageId=$mesId;
		$remes->godId=$godId;
		$remes->godName=$godName;
		$remes->head=$head;
		$remes->add();
		$map=array(
		  "status"=>0,
		  "msg"=>"成功"
		 );
		 $this->ajaxReturn($map);
	}
	public function remesByMesId(){
		$mesId=I("mesId");
		$remes=M("remessage");
		$map['messageId']=$mesId;
		$list=$remes->where($map)->order("createdate")->select();
		$map=array(
		  "status"=>0,
		  "msg"=>"成功",
		  "list"=>$list
		 );
		 $this->ajaxReturn($map);
	}
	public function a(){
		 $photoName=uuid();
	     $target_path  = "./Application/Common/photo/";//接收文件目录   
	    	if(!file_exists($target_path)){
		     mkdir($target_path);
		    }
		 
	      $target_path = $target_path. $photoName.'.png'; 
	      if($_FILES['uploadedfile']['tmp_name']){
		      if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_path)) {
		    
		       }else{     
		       	$map=array(
				  "status"=>1,
				  "msg"=>"图片上传失败",
				 );
				  $this->ajaxReturn($map);    
		       }
			
			}
		if($n){
			  $map=array(
			  "status"=>0,
			  "msg"=>"成功",
			 );
		}else{
		 $map=array(
		  "status"=>1,
		  "msg"=>"失败"
		 );
		}
		 $this->ajaxReturn($map);
	}
}
?>