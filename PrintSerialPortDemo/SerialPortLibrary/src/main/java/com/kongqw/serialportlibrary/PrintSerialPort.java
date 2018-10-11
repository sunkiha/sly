package com.kongqw.serialportlibrary;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.kongqw.serialportlibrary.listener.OnOpenSerialPortListener;
import com.kongqw.serialportlibrary.listener.OnSerialPortDataListener;

import java.io.File;

public class PrintSerialPort extends SerialPortManager implements OnOpenSerialPortListener {
    private Context mContext;
    private String TAG = this.getClass().getSimpleName();
    private OnSerialPortDataListener listener;
    private static PrintSerialPort mInstance = null;

    private PrintSerialPort(Context context) {
        this.mContext = context;
    }

    private PrintSerialPort(String path, int baudRate, Context context) {
        this.mContext = context;
        this.setOnOpenSerialPortListener(this);
        this.openSerialPort(path, baudRate);
    }

    public static PrintSerialPort getInstance(Context context) {
        return new PrintSerialPort(context);
    }

    public void openPort(String path, int baudRate) {
        this.setOnOpenSerialPortListener(this);
        this.openSerialPort(path, baudRate);
    }

    public void closePort() {
        this.closeSerialPort();
    }

    public void onReceiveData(byte[] datas) {
        for (int i = 0; i < datas.length; ++i) {
            Log.d("xxxxxxxxxx", i + "onReceiveData：" + datas[i]);
        }

        Log.d("xxxxxxxxxx", "onReceiveData：" + CommonUtil.bytesToHexString(datas));
        this.listener.onDataReceived(datas);
    }

    public void onSendData(byte[] datas) {
        for (int i = 0; i < datas.length; ++i) {
            Log.d("xxxxxxxxxx", i + "onSendData：" + datas[i]);
        }

        this.listener.onDataSent(datas);
    }

    public void onSuccess(File device) {
        Log.d("xxxxxxxxxx", "onSuccess：串口打开成功");
    }

    @Override
    public void onFail(File device, Status status) {
        Log.d("xxxxxxxxxx", "onFailure：串口打开失败");
    }


    public void sendHex(String t) {
        Log.d(this.TAG, "sendHex():" + t);
        final byte[] bOutArray = CommonUtil.hexToByteArr(t);
        (new Handler(Looper.getMainLooper())).postDelayed(new Runnable() {
            public void run() {
                PrintSerialPort.this.sendBytes(bOutArray);
            }
        }, 200L);
    }

    public void sendHex(final byte[] data) {
        (new Handler(Looper.getMainLooper())).postDelayed(new Runnable() {
            public void run() {
                PrintSerialPort.this.sendBytes(data);
            }
        }, 200L);
    }

   public SerialPortManager setOnSerialPortDataListener(OnSerialPortDataListener listener){
        this.listener=listener;
       return null;
   }
}
