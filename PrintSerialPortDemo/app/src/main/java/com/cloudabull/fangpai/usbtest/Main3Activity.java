package com.cloudabull.fangpai.usbtest;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CompoundButton;

import com.cloudabull.fangpai.R;
import com.kyleduo.switchbutton.SwitchButton;

import java.util.ArrayList;
import java.util.List;

import fangpai.cloudabull.com.usblibrary.bean.UsbObtainBean;
import fangpai.cloudabull.com.usblibrary.database.USBDataBase;
import fangpai.cloudabull.com.usblibrary.listener.IUSBListener;
import fangpai.cloudabull.com.usblibrary.usb.MyUSBPrinter;
import fangpai.cloudabull.com.usblibrary.utils.GsonUtils;
import fangpai.cloudabull.com.usblibrary.utils.UsbSaveType;
import fangpai.cloudabull.com.usblibrary.utils.UsbUseType;

public class Main3Activity extends AppCompatActivity implements CompoundButton.OnCheckedChangeListener, View.OnClickListener {

    MyUSBPrinter usbPrinter;
    SwitchButton esc_sb_setting, tsc_sb_setting;
    Button esc_bt_print, tsc_bt_print;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main3);
        usbPrinter = MyUSBPrinter.getInstance();
        usbPrinter.initPrinter(this, UsbUseType.USE_SCAN_PRINTER);
        esc_sb_setting = findViewById(R.id.esc_sb_setting);
        tsc_sb_setting = findViewById(R.id.tsc_sb_setting);
        esc_bt_print = findViewById(R.id.esc_bt_print);
        tsc_bt_print = findViewById(R.id.tsc_bt_print);

        esc_sb_setting.setOnCheckedChangeListener(this);
        tsc_sb_setting.setOnCheckedChangeListener(this);

        esc_bt_print.setOnClickListener(this);
        tsc_bt_print.setOnClickListener(this);

    }


    @Override
    public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
        switch (buttonView.getId()){
            case R.id.esc_sb_setting:
                if (isChecked){
                    usbPrinter.initPrinter(this, UsbUseType.USE_ADD_PRINTER, UsbSaveType.ADD_ESC_PRINT);
                }else {
                    UsbObtainBean usb_esc_tsc = USBDataBase.getUSB_ESC_TSC(Main3Activity.this);
                    List<UsbObtainBean.UsbDataBean> escList = new ArrayList<>();
                    escList.add(new UsbObtainBean.UsbDataBean(1155,1803));
                    escList.add(new UsbObtainBean.UsbDataBean(1305,8211));//int vid, int pid
                    escList.add(new UsbObtainBean.UsbDataBean(1155,22304));
                    escList.add(new UsbObtainBean.UsbDataBean(6790,30084));
                    escList.add(new UsbObtainBean.UsbDataBean(26728,1536));
                    escList.add(new UsbObtainBean.UsbDataBean(1659,8965));
                    escList.add(new UsbObtainBean.UsbDataBean(1046,20497));
                    usb_esc_tsc.setEscList(escList);
                    USBDataBase.setUSB_ESC_TSC(Main3Activity.this,GsonUtils.toJsonString(usb_esc_tsc));

                }
                break;
            case R.id.tsc_sb_setting:
                if (isChecked){
                    usbPrinter.initPrinter(this, UsbUseType.USE_ADD_PRINTER, UsbSaveType.ADD_TSC_PRINT);
                }else {
                    UsbObtainBean usb_esc_tsc = USBDataBase.getUSB_ESC_TSC(Main3Activity.this);
                    List<UsbObtainBean.UsbDataBean> tscList = new ArrayList<>();
                    tscList.add(new UsbObtainBean.UsbDataBean(1137,85));
                    tscList.add(new UsbObtainBean.UsbDataBean(1137,23));//int vid, int pid
                    tscList.add(new UsbObtainBean.UsbDataBean(26728,1280));
                    tscList.add(new UsbObtainBean.UsbDataBean(1155,22339));
                    usb_esc_tsc.setEscList(tscList);
                    USBDataBase.setUSB_ESC_TSC(Main3Activity.this,GsonUtils.toJsonString(usb_esc_tsc));
                }
                break;
        }
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.esc_bt_print://小票打印
                if (esc_sb_setting.isChecked()) {
                    byte[] check = PrinterCmdUtils.transfer();
                    byte[] esc_bytes = PrinterCmdUtils.clientPaper2();
                    usbPrinter.print(check, true, esc_bytes, 1, false, null, new IUSBListener() {
                        @Override
                        public void onUsbListener(String type) {
                            Log.d("usbPrinter", "小票："+type);
                        }
                    });
                }
                break;
            case R.id.tsc_bt_print://标签打印

                if (tsc_sb_setting.isChecked()){
                    usbPrinter.print(null, false, null, 0, true, getLabelData(), new IUSBListener() {
                        @Override
                        public void onUsbListener(String type) {
                            Log.d("usbPrinter", "标签："+type);
                        }
                    });
                }
                break;
        }
    }

    private byte[][] getLabelData(){

        String labellingData = "{\"biaoQianList\":[{\"ip\":\"192.168.1.208\",\"shiWuList\":[{\"haoma\":\"取餐号：测试\",\"ip\":\"192.168.1.1\",\"mingcheng\":\"菜品名\",\"shijian\":\"时间：01-01/00:00:00\",\"shuxingList\":[\"属性1\",\"属性2\",\"属性3\"]}]}]}";
        BiaoQianBean biaoQianBean = GsonUtils.getObjFromJsonString(labellingData, BiaoQianBean.class);
        if (biaoQianBean == null) {
            biaoQianBean = new BiaoQianBean();
        }
        List<BiaoQianBean.BiaoQianData> biaoQianList = biaoQianBean.getBiaoQianList();
        if (biaoQianList == null) {
            biaoQianList = new ArrayList<>();
        }

        List<byte[]> labelList = new ArrayList<>();

        for (int i = 0; i < biaoQianList.size(); i++) {
            BiaoQianBean.BiaoQianData biaoQianData = biaoQianList.get(i);
            List<BiaoQianBean.BiaoQianData.ShiWu> shiWuList = biaoQianData.getShiWuList();
            for (int j = 0; j < shiWuList.size(); j++) {
                BiaoQianBean.BiaoQianData.ShiWu shiWu = shiWuList.get(j);
                byte[] bytes = PrinterCmdUtils.printMsg(shiWu, this);
                labelList.add(bytes);
            }
        }

        byte[][] labelBytes = labelList.toArray(new byte[labelList.size()][]);

        return labelBytes;
    }

}
