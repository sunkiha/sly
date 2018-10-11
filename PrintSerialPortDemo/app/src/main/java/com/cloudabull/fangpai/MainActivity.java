package com.cloudabull.fangpai;

import android.Manifest;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import com.kongqw.serialportlibrary.PrintSerialPort;
import com.kongqw.serialportlibrary.SerialPortManager;
import com.kongqw.serialportlibrary.listener.OnOpenSerialPortListener;
import com.kongqw.serialportlibrary.listener.OnSerialPortDataListener;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.List;

import kr.co.namee.permissiongen.PermissionGen;

import static com.cloudabull.fangpai.PrinterCmdUtils2.alignCenter;
import static com.cloudabull.fangpai.PrinterCmdUtils2.alignLeft;
import static com.cloudabull.fangpai.PrinterCmdUtils2.alignRight;
import static com.cloudabull.fangpai.PrinterCmdUtils2.byteMerger;
import static com.cloudabull.fangpai.PrinterCmdUtils2.feedPaperCutPartial;
import static com.cloudabull.fangpai.PrinterCmdUtils2.fontSizeSetBig;
import static com.cloudabull.fangpai.PrinterCmdUtils2.isZhongWen;
import static com.cloudabull.fangpai.PrinterCmdUtils2.nextLine;

/*
import fangpai.cloudabull.com.serialportlibrary.PrintUtils;
import fangpai.cloudabull.com.serialportlibrary.serial.SerialPortManager;
import fangpai.cloudabull.com.serialportlibrary.serial.listener.OnDataReceivedListener;
import fangpai.cloudabull.com.serialportlibrary.utils.SystemUtil;
import kr.co.namee.permissiongen.PermissionGen;

import static fangpai.cloudabull.com.serialportlibrary.PrinterCmdUtils.alignCenter;
import static fangpai.cloudabull.com.serialportlibrary.PrinterCmdUtils.alignLeft;
import static fangpai.cloudabull.com.serialportlibrary.PrinterCmdUtils.alignRight;
import static fangpai.cloudabull.com.serialportlibrary.PrinterCmdUtils.byteMerger;
import static fangpai.cloudabull.com.serialportlibrary.PrinterCmdUtils.feedPaperCutPartial;
import static fangpai.cloudabull.com.serialportlibrary.PrinterCmdUtils.fontSizeSetBig;
import static fangpai.cloudabull.com.serialportlibrary.PrinterCmdUtils.isZhongWen;
import static fangpai.cloudabull.com.serialportlibrary.PrinterCmdUtils.nextLine;
*/

public class MainActivity extends AppCompatActivity {

    // private PrintUtils printUtils;
    EditText editText;
    SerialPortManager serialPortManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        editText = findViewById(R.id.d);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            PermissionGen.with(MainActivity.this)
                    .addRequestCode(100)
                    .permissions(Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    .request();
        }

        try {
            // Toast.makeText(this, SystemUtil.getDeviceBrand(), Toast.LENGTH_LONG).show();
        } catch (Exception e) {
            Toast.makeText(this, e.getMessage(), Toast.LENGTH_LONG).show();
            e.printStackTrace();
        }
        serialPortManager = new SerialPortManager();
        serialPortManager.setOnOpenSerialPortListener(new OnOpenSerialPortListener() {
            @Override
            public void onSuccess(File device) {
                Toast.makeText(editText.getContext(), "打开成功", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onFail(File device, Status status) {
                Toast.makeText(editText.getContext(), "打开失败", Toast.LENGTH_SHORT).show();
            }
        });
        serialPortManager.setOnSerialPortDataListener(new OnSerialPortDataListener() {
            @Override
            public void onDataReceived(byte[] bytes) {
                Toast.makeText(editText.getContext(), new String(bytes), Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onDataSent(byte[] bytes) {

            }
        });
    }


    public void opens(View view) {
        //Toast.makeText(this, SystemUtil.getDeviceBrand(), Toast.LENGTH_LONG).show();

        serialPortManager.openSerialPort(editText.getText().toString(), 9600);
        // printUtils = PrintUtils.getInstance(this);
   /*     printUtils = PrintUtils.getInstance(this);
        printUtils.openPort(editText.getText().toString(), 9600);
        printUtils.setListener(new OnDataReceivedListener() {
            @Override
            public void onDataReceived(String data) {
                Log.d("xxxxxxxxxx", "returnData: " + data);
                Toast.makeText(MainActivity.this, data, Toast.LENGTH_LONG).show();
            }

        });*/
    }

    public void printData(View view) {
        final Bill bill = new Bill();
        bill.setOrder_number("订单号：231828348993854828384");
        bill.setTotal_price("总计：58.00");
        bill.setPay_type("支付方式：现金支付");
        bill.setShop_name("龙龙食府");
        bill.setTime("时间：2018-06-09 17:47:00");
        List<Bill.Goods> mList = new ArrayList<>();
        mList.add(new Bill.Goods("5.00", "2", "红牛"));
        mList.add(new Bill.Goods("3.00", "1", "雪碧"));
        mList.add(new Bill.Goods("15.00", "3", "黄鹤楼"));
        bill.setGoodsList(mList);
        (new Handler(Looper.getMainLooper())).postDelayed(new Runnable() {
            public void run() {
                serialPortManager.sendBytes(printerBill(bill));
            }
        }, 200L);

        // printUtils.sendHexCMD(printerBill(bill));
    }

    public void closePort(View view) {
        serialPortManager.closeSerialPort();
    }

    /**
     * 打印菜单数据
     *
     * @param bill
     * @return
     */
    public static byte[] printerBill(Bill bill) {
        try {
            byte[] Store_name;
            if (bill.getShop_name() != null && !bill.getShop_name().equals("")) {
                Store_name = (bill.getShop_name() + "\n").getBytes("gb2312");
            } else {
                Store_name = ("").getBytes("gb2312");
            }
            //2行
            byte[] Time;
            if (bill.getTime() != null && !bill.getTime().equals("")) {
                if (bill.getTime().equals("cs")) {
                    Time = ("\n").getBytes("gb2312");
                } else {
                    Time = ("\n" + bill.getTime() + "\n").getBytes("gb2312");
                }
            } else {
                Time = ("").getBytes("gb2312");
            }
            byte[] order_number;
            byte[] henxian;
            byte[] lanmu;
            if (bill.getOrder_number() != null && !bill.getOrder_number().equals("")) {
                order_number = (bill.getOrder_number() + "\n").getBytes("gb2312");
                henxian = ("--------------------------------" + "\n").getBytes("gb2312");
                lanmu = ("菜单               数量  价格   " + "\n").getBytes("gb2312");
                Log.d("xxxxxxxxxxxx", "打印栏目");
            } else {
                order_number = ("").getBytes("gb2312");
                henxian = ("").getBytes("gb2312");
                lanmu = ("").getBytes("gb2312");
            }
            StringBuffer sb = new StringBuffer();
            if (bill.getGoodsList() != null && !bill.getGoodsList().equals("")) {
                List<Bill.Goods> list = bill.getGoodsList();
                for (int i = 0; i < list.size(); i++) {
                    Bill.Goods goods = list.get(i);
                    String goods_name = goods.getGoods_name();
                    String goods_num = goods.getGoods_num();
                    String goods_price = goods.getGoods_price();
                    sb.append(dataStringFoods(goods_name, goods_num, goods_price, 32) + "\n");
                }
            }
            byte[] food = (sb.toString()).getBytes("gb2312");
            byte[] Price_all;//总价
            if (bill.getTotal_price() != null && !bill.getTotal_price().equals("")) {
                Price_all = (bill.getTotal_price() + "\n").getBytes("gb2312");
            } else {
                Price_all = ("").getBytes("gb2312");
            }
            byte[] Pay_type;
            if (bill.getPay_type() != null && !bill.getPay_type().equals("")) {
                Pay_type = (bill.getPay_type() + "\n").getBytes("gb2312");
            } else {
                Pay_type = ("").getBytes("gb2312");
            }
            byte[][] cmdBytes = {
                    nextLine(1),
                    alignCenter(), fontSizeSetBig(4), Store_name,
                    alignLeft(), fontSizeSetBig(1), Time,
                    order_number,
                    henxian,
                    lanmu,
                    food,
                    henxian,
                    alignRight(),
                    Price_all,
                    Pay_type,
                    alignLeft(),
                    feedPaperCutPartial()
            };
            return byteMerger(cmdBytes);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String dataStringFoods(String food_name, String food_num, String food_price,
                                         int num) {
        String result = null;
        StringBuffer sb = new StringBuffer();
        try {
            char[] name_arr = food_name.toCharArray();//字符數
            Log.d("abcd", "name_arr: " + name_arr.length);
            char[] num_arr = food_num.toCharArray();
            Log.d("abcd", "num_arr: " + num_arr.length);
            char[] price_arr = food_price.toCharArray();
            for (int i = 0; i < num; i++) {
                if (i == 0) {
                    if (name_arr.length > 9) {
                        sb.append(name_arr[0]);
                        sb.append(name_arr[1]);
                        sb.append(name_arr[2]);
                        sb.append(name_arr[3]);
                        sb.append(name_arr[4]);
                        sb.append(name_arr[5]);
                        sb.append(name_arr[6]);
                        sb.append(name_arr[7]);
                        sb.append(".");
                        sb.append(".");
                        sb.append(name_arr[name_arr.length - 1]);
                        int znum = 0;
                        char[] chars = sb.toString().toCharArray();
                        for (int j = 0; j < chars.length; j++) {
                            if (isZhongWen(chars[j])) {
                                znum++;//中文個數
                            }
                        }
                        Log.d("dataStringSet2", "znum: " + znum);
                        for (int j = 0; j < 9 - znum; j++) {
                            //一個中文占2位，數字占1位
                            sb.append(" ");//40-4*znum =
                        }
                        i = 20;
                    } else {
                        int zhongwen = 0;
                        for (int j = 0; j < name_arr.length; j++) {
                            sb.append(name_arr[j]);
                            if (isZhongWen(name_arr[j])) {
                                zhongwen++;
                            }
                        }
                        i = zhongwen * 2 + name_arr.length - zhongwen;
                        Log.d("dataStringSet2", "dataStringSet2: i--->" + i);
//                        sb.append(" ");
                    }
                } else if (i == 22) {
                    for (int j = 0; j < num_arr.length; j++) {
                        sb.append(num_arr[j]);
                        i++;
                    }
                } else if (i == 26) {
                    for (int j = 0; j < price_arr.length; j++) {
                        sb.append(price_arr[j]);
                        i++;
                    }
                } else {
                    sb.append(" ");
                }
            }
            result = sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
