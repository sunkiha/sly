package com.moim.leonsun.mobimtest;

import android.Manifest;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.UserManager;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.alibaba.fastjson.JSON;
import com.mob.MobSDK;
import com.mob.MobUser;
import com.mob.imsdk.MobIM;
import com.mob.imsdk.MobIMCallback;
import com.mob.imsdk.MobIMMessageReceiver;
import com.mob.imsdk.MobIMReceiver;
import com.mob.imsdk.model.IMConversation;
import com.mob.imsdk.model.IMMessage;
import com.mob.imsdk.model.IMUser;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {
    private MobIMReceiver generalReceiver;
    private MobIMMessageReceiver messageReceiver;
    TextView textView;
    Button b;
    Button setting;
    EditText c;
    EditText uid;
    EditText localuserid;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        textView = findViewById(R.id.a);
        b = findViewById(R.id.b);
        setting = findViewById(R.id.setting);
        c = findViewById(R.id.c);
        uid = findViewById(R.id.uid);
        localuserid = findViewById(R.id.localuserid);
       // setUser();
        imConnect();
        b.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                sendMsg();
                Toast.makeText(getBaseContext(),"发送成功", Toast.LENGTH_SHORT).show();
            }
        });
        setting.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setUser();
                Toast.makeText(getBaseContext(),"设置成功", Toast.LENGTH_SHORT).show();
            }
        });
        MobSDK.getUser(new MobUser.OnUserGotListener() {
            @Override
            public void onUserGot(MobUser mobUser) {
                if(!TextUtils.isEmpty(mobUser.getId())){
                    localuserid.setText(mobUser.getId());
                }
                //Toast.makeText(getBaseContext(), mobUser.getId(), Toast.LENGTH_SHORT).show();
            }
        });
    }

    void setUser() {
        IMUser imUser = new IMUser();
        imUser.setId(localuserid.getText().toString());
        imUser.setAvatar("1sd42.jpg");
        imUser.setNickname("sfs4df");
        // UserManager.saveUserInfo(imUser);
        MobSDK.setUser(imUser.getId(), imUser.getNickname(), imUser.getAvatar(), null);
    }
//连接状态以及聊天消息监听
    void imConnect() {
        //先加载会话
        messageReceiver = new MobIMMessageReceiver() {
            public void onMessageReceived(List<IMMessage> messageList) {
                //接收到消息，则刷新界面
                System.out.println("sly接收到消息" + messageList.get(0).getBody());
                //Toast.makeText(getBaseContext(), JSON.toJSONString(messageList), Toast.LENGTH_SHORT).show();
               // textView.setText(JSON.toJSONString(messageList));
                textView.setText(messageList.get(0).getBody());
            }
        };
        generalReceiver = new MobIMReceiver() {
            public void onConnected() {
                //setIMConnectStatus(0);
                //连接im成功后，刷新会话列表
                // refreshData();
                System.out.println("sly连接成功");
                Toast.makeText(getBaseContext(), "sly连接成功", Toast.LENGTH_SHORT).show();
            }

            public void onConnecting() {
                //setIMConnectStatus(1);
                System.out.println("sly连接中");
                //Toast.makeText(getBaseContext(), "ddd", Toast.LENGTH_SHORT).show();
            }

            public void onDisconnected(int error) {
                //setIMConnectStatus(error);
                System.out.println("sly连接失败" + error + "");
                Toast.makeText(getBaseContext(), "sly连接失败", Toast.LENGTH_SHORT).show();
            }
        };
        MobIM.addMessageReceiver(messageReceiver);
        MobIM.addGeneralReceiver(generalReceiver);
    }

    void sendMsg() {
        IMMessage imMessage = MobIM.getChatManager().createTextMessage(uid.getText().toString(), c.getText().toString(), IMConversation.TYPE_USER);
        MobIM.getChatManager().sendMessage(imMessage, new MobIMCallback<Void>() {
            public void onSuccess(Void result) {
                getParent().runOnUiThread(new Runnable() {
                    public void run() {
                        System.out.println("发送成功");
                    }
                });
            }

            public void onError(int code, String message) {

            }
        });
    }
}
