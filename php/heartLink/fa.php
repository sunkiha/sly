<?php

require_once ('Channel.class.php');
$channel = new Channel("VQ5gneueO41HpUOVCSwiXAUv","y63NVGNYNU4ItMvhVXHZKhpNUSGTw9pV");
//$d=$channel.queryBindList();
// $channel = new Channel ( $apiKey, $secretKey ) ;
	//推送消息到某个user，设置push_type = 1; 
	//推送消息到一个tag中的全部user，设置push_type = 2;
	//推送消息到该app中的全部user，设置push_type = 3;
	$push_type = 2; //推送单播消息
	//$optional[Channel::USER_ID] = $user_id; //如果推送单播消息，需要指定user
	$optional[Channel::TAG_NAME] = "2";  //如果推送tag消息，需要指定tag_name

	//指定发到android设备
	$optional[Channel::DEVICE_TYPE] = 3;
	//指定消息类型为通知
	$optional[Channel::MESSAGE_TYPE] = 0;
	//通知类型的内容必须按指定内容发送，示例如下：
	$message = '{ 
			"title": "test_push",
			"description": "open url",
			"notification_basic_style":7,
			"open_type":1,
			"url":"http://www.baidu.com"
 		}';
	
	$message_key = "msg_key";
    $ret = $channel->pushMessage ( $push_type, $message, $message_key, $optional ) ;
    if ( false === $ret )
    {
       /* error_output ( 'WRONG, ' . __FUNCTION__ . ' ERROR!!!!!' ) ;
        error_output ( 'ERROR NUMBER: ' . $channel->errno ( ) ) ;
        error_output ( 'ERROR MESSAGE: ' . $channel->errmsg ( ) ) ;
        error_output ( 'REQUEST ID: ' . $channel->getRequestId ( ) );*/
        echo '失败';
    }
    else
    {
        /*right_output ( 'SUCC, ' . __FUNCTION__ . ' OK!!!!!' ) ;
        right_output ( 'result: ' . print_r ( $ret, true ) ) ;*/
        echo "成功";
    }
?>
