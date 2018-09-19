<?php
namespace Home\Controller;
use Think\Controller;
class WxController extends Controller {
	public function connetService(){
		/* $map=array(
		  "status"=>1,
		  "msg"=>"注册失败"
		 );
		$this->ajaxReturn($map);*/
		/*$echostr=I("echostr");
		echo $echostr;*/
			//get post data, May be due to the different environments
		$postStr = $GLOBALS["HTTP_RAW_POST_DATA"];
$postStr="<xml>
 <ToUserName><![CDATA[toUser]]></ToUserName>
 <FromUserName><![CDATA[fromUser]]></FromUserName> 
 <CreateTime>1348831860</CreateTime>
 <MsgType><![CDATA[text]]></MsgType>
 <Content><![CDATA[this is a test]]></Content>
 <MsgId>1234567890123456</MsgId>
 </xml>";
      	//extract post data
		if (!empty($postStr)){
                /* libxml_disable_entity_loader is to prevent XML eXternal Entity Injection,
                   the best way is to check the validity of xml by yourself */
                libxml_disable_entity_loader(true);
              	$postObj = simplexml_load_string($postStr, 'SimpleXMLElement', LIBXML_NOCDATA);
                $fromUsername = $postObj->FromUserName;
                $toUsername = $postObj->ToUserName;
                $keyword = trim($postObj->Content);
                $time = time();
                header("Content-type:text/xml;charset=utf-8");
                  $textTpl = "<xml>
							<ToUserName>%s</ToUserName>
							<FromUserName>%s</FromUserName>
							<CreateTime>%s</CreateTime>
							<MsgType>%s</MsgType>
							<Content>%s</Content>
							<FuncFlag>0</FuncFlag>
							</xml>";             
				if(!empty( $keyword ))
                {
              		$msgType = "text";
                	$contentStr = "Welcome to wechat world!";
                	$resultStr = sprintf($textTpl, $fromUsername, $toUsername, $time, $msgType, $contentStr);
                	//$resultStr=sprintf($textTpl,"sd");
                	
                	echo $resultStr;
                }else{
                	echo "Input something...";
                }

        }else {
        	echo "";
        	exit;
        }
	}
	
}
?>