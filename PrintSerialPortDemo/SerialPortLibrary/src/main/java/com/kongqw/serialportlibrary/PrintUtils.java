package com.kongqw.serialportlibrary;

import android.content.Context;

import com.kongqw.serialportlibrary.listener.OnDataReceivedListener;
import com.kongqw.serialportlibrary.listener.OnOpenSerialPortListener;
import com.kongqw.serialportlibrary.listener.OnSerialPortDataListener;

public abstract class PrintUtils implements OnSerialPortDataListener {
    private static PrintUtils instance;
    private PrintSerialPort printSerialPort;
    private OnDataReceivedListener listener;

    public PrintUtils(Context context) {
        this.printSerialPort = PrintSerialPort.getInstance(context);
        this.printSerialPort.setOnSerialPortDataListener(this);
    }

    public void setListener(OnDataReceivedListener listener) {
        this.listener = listener;
    }

    public static synchronized PrintUtils getInstance(Context context) {
        if (instance == null) {
            instance = new PrintUtils(context) {
            };
        }

        return instance;
    }

    public void openPort(String path, int baudRate) {
        this.printSerialPort.openPort(path, baudRate);
    }

    public void closePort() {
        this.printSerialPort.closePort();
    }

    public void sendHexCMD(String cmd) {
        this.printSerialPort.sendHex(cmd);
    }

    public void sendHexCMD(byte[] cmd) {
        this.printSerialPort.sendHex(cmd);
    }

    @Override
    public void onDataReceived(byte[] bytes) {
        this.listener.onDataReceived(new String(bytes));
    }

    @Override
    public void onDataSent(byte[] bytes) {

    }
}

