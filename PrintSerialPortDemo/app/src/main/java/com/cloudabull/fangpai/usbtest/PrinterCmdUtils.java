package com.cloudabull.fangpai.usbtest;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.os.Build;
import android.support.annotation.RequiresApi;
import android.util.Log;

import com.cloudabull.fangpai.usbtest.xinbiaoqian.LabelCommand;
import com.cloudabull.fangpai.usbtest.xinbiaoqian.LabelUtils;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Vector;

/**
 * Created by Administrator on 2017/6/28.
 */

public class PrinterCmdUtils {

    /**
     * 这些数据源自爱普生指令集,为POS机硬件默认
     */

    public static final byte ESC = 27;//换码
    public static final byte FS = 28;//文本分隔符
    public static final byte GS = 29;//组分隔符
    public static final byte DLE = 16;//数据连接换码
    public static final byte EOT = 4;//传输结束
    public static final byte ENQ = 5;//询问字符
    public static final byte SP = 32;//空格
    public static final byte HT = 9;//横向列表
    public static final byte LF = 10;//打印并换行（水平定位）
    public static final byte CR = 13;//归位键
    public static final byte FF = 12;//走纸控制（打印并回到标准模式（在页模式下） ）
    public static final byte CAN = 24;//作废（页模式下取消打印数据 ）



//------------------------打印机初始化-----------------------------


    /**
     * 打印机初始化
     * @return
     */
    public static byte[] init_printer()
    {
        byte[] result = new byte[2];
        result[0] = ESC;
        result[1] = 64;
        return result;
    }


//------------------------换行-----------------------------


    /**
     * 换行
     * @param lineNum 要换几行
     * @return
     */
    public static byte[] nextLine(int lineNum)
    {
        byte[] result = new byte[lineNum];
        for(int i=0;i<lineNum;i++)
        {
            result[i] = LF;
        }

        return result;
    }

    /**
     * 实时状态传送
     * @return
     */
    public static byte[] transfer(){
        byte[] result = new byte[3];
        result[0] = DLE;
        result[1] = EOT;
        result[2] = 1;
        return result;
    }


//------------------------下划线-----------------------------


    /**
     * 绘制下划线（1点宽）
     * @return
     */
    public static byte[] underlineWithOneDotWidthOn()
    {
        byte[] result = new byte[3];
        result[0] = ESC;
        result[1] = 45;
        result[2] = 1;
        return result;
    }


    /**
     * 绘制下划线（2点宽）
     * @return
     */
    public static byte[] underlineWithTwoDotWidthOn()
    {
        byte[] result = new byte[3];
        result[0] = ESC;
        result[1] = 45;
        result[2] = 2;
        return result;
    }
    /**
     * 取消绘制下划线
     * @return
     */
    public static byte[] underlineOff()
    {
        byte[] result = new byte[3];
        result[0] = ESC;
        result[1] = 45;
        result[2] = 0;
        return result;
    }


//------------------------加粗-----------------------------


    /**
     * 选择加粗模式
     * @return
     */
    public static byte[] boldOn()
    {
        byte[] result = new byte[3];
        result[0] = ESC;
        result[1] = 69;
        result[2] = 0xF;
        return result;
    }


    /**
     * 取消加粗模式
     * @return
     */
    public static byte[] boldOff()
    {
        byte[] result = new byte[3];
        result[0] = ESC;
        result[1] = 69;
        result[2] = 0;
        return result;
    }


//------------------------对齐-----------------------------


    /**
     * 左对齐
     * @return
     */
    public static byte[] alignLeft()
    {
        byte[] result = new byte[3];
        result[0] = ESC;
        result[1] = 97;
        result[2] = 0;
        return result;
    }


    /**
     * 居中对齐
     * @return
     */
    public static byte[] alignCenter()
    {
        byte[] result = new byte[3];
        result[0] = ESC;
        result[1] = 97;
        result[2] = 1;
        return result;
    }


    /**
     * 右对齐
     * @return
     */
    public static byte[] alignRight()
    {
        byte[] result = new byte[3];
        result[0] = ESC;
        result[1] = 97;
        result[2] = 2;
        return result;
    }


    /**
     * 水平方向向右移动col列
     * @param col
     * @return
     */
    public static byte[] set_HT_position( byte col )
    {
        byte[] result = new byte[4];
        result[0] = ESC;
        result[1] = 68;
        result[2] = col;
        result[3] = 0;
        return result;
    }
//------------------------字体变大-----------------------------


//    /**
//     * 字体变大为标准的n倍
//     * @param num
//     * @return
//     */
//    public static byte[] fontSizeSetBig(int num)
//    {
//        byte realSize = 0;
//        switch (num)
//        {
//            case 1:
//                realSize = 0;break;
//            case 2:
//                realSize = 17;break;
//            case 3:
//                realSize = 34;break;
//            case 4:
//                realSize = 51;break;
//            case 5:
//                realSize = 68;break;
//            case 6:
//                realSize = 85;break;
//            case 7:
//                realSize = 102;break;
//            case 8:
//                realSize = 119;break;
//        }
//        byte[] result = new byte[3];
//        result[0] = 29;
//        result[1] = 33;
//        result[2] = realSize;
//        return result;
//    }


    /**
     * 字体变大为标准的n倍
     * @param num 1:正常大小 2:两倍高 3:两倍宽 4:两倍大小 5:三倍高 6:三倍宽 7:三倍大小
     * @return
     */
    public static byte[] fontSizeSetBig(int num)
    {
        byte realSize = 0;
        switch (num)
        {
            case 1:
                realSize = 0;break;
            case 2:
                realSize = 1;break;
            case 3:
                realSize = 16;break;
            case 4:
                realSize = 17;break;
            case 5:
                realSize = 2;break;
            case 6:
                realSize = 32;break;
            case 7:
                realSize = 34;break;
        }
        byte[] result = new byte[3];
        result[0] = 29;
        result[1] = 33;
        result[2] = realSize;
        return result;
    }


//------------------------字体变小-----------------------------


    /**
     * 字体取消倍宽倍高
     * @param num
     * @return
     */
    public static byte[] fontSizeSetSmall(int num)
    {
        byte[] result = new byte[3];
        result[0] = ESC;
        result[1] = 33;

        return result;
    }


//------------------------切纸-----------------------------


    /**
     * 进纸并全部切割
     * @return
     */
    public static byte[] feedPaperCutAll()
    {
        byte[] result = new byte[4];
        result[0] = GS;
        result[1] = 86;
        result[2] = 65;
        result[3] = 0;
        return result;
    }


    /**
     * 进纸并切割（左边留一点不切）
     * @return
     */
    public static byte[] feedPaperCutPartial()
    {
        byte[] result = new byte[4];
        result[0] = GS;
        result[1] = 86;
        result[2] = 66;
        result[3] = 0;
        return result;
    }

    //------------------------切纸-----------------------------
    public static byte[] byteMerger(byte[] byte_1, byte[] byte_2){
        byte[] byte_3 = new byte[byte_1.length+byte_2.length];
        System.arraycopy(byte_1, 0, byte_3, 0, byte_1.length);
        System.arraycopy(byte_2, 0, byte_3, byte_1.length, byte_2.length);
        return byte_3;
    }


    public static byte[] byteMerger(byte[][] byteList){

        int length = 0;
        for(int i=0;i < byteList.length;i++)
        {
            length += byteList[i].length;//所有byte的元素数量
        }
        byte[] result = new byte[length];

        int index = 0;
        for(int i=0;i<byteList.length;i++)
        {
            byte[] nowByte = byteList[i];
            for(int k=0;k<byteList[i].length;k++)
            {
                result[index] = nowByte[k];
                index++;
            }
        }
        return result;
    }


    public static byte[] clientPaper()
    {
        try {
            byte[] next2Line = nextLine(2);

            byte[] title =  "出餐单（午餐）**万通中心店".getBytes( "gb2312");

            byte[] boldOn = boldOn();

            byte[] fontSize2Big = fontSizeSetBig(3);

            byte[] center= alignCenter();

            byte[] Focus =  "网 507 ".getBytes( "gb2312");

            byte[] boldOff = boldOff();

            byte[] fontSize2Small = fontSizeSetSmall(3);

            byte[] left= alignLeft();

            byte[] orderSerinum =  "订单编号：11234 ".getBytes( "gb2312");

            boldOn = boldOn();

            byte[] fontSize1Big = fontSizeSetBig(2);

            byte[] FocusOrderContent =  "韭菜鸡蛋饺子-小份（单） ".getBytes( "gb2312");

            boldOff = boldOff();

            byte[] fontSize1Small = fontSizeSetSmall(2);

            next2Line = nextLine(2);

            byte[] priceInfo =  "应收:22元 优惠：2.5元  ".getBytes( "gb2312");

            byte[] nextLine = nextLine(1);

            byte[] priceShouldPay =  "实收:19.5元 ".getBytes( "gb2312");

            nextLine = nextLine(1);


            byte[] takeTime =  "取餐时间:2015-02-13 12:51:59 ".getBytes( "gb2312");

            nextLine = nextLine(1);

            byte[] setOrderTime =  "下单时间：2015-02-13 12:35:15 ".getBytes( "gb2312");


            byte[] tips_1 =  "微信关注 ** 自助下单每天免1元 ".getBytes( "gb2312");

            nextLine = nextLine(1);

            byte[] tips_2 =  "饭后点评再奖5毛 ".getBytes( "gb2312");

            nextLine = nextLine(1);

            byte[] breakPartial = feedPaperCutPartial();

            byte[][] cmdBytes= {

                    title,nextLine,

                    center,boldOn,fontSize2Big,Focus,boldOff,fontSize2Small,next2Line,

                    left,orderSerinum,nextLine,

                    center,boldOn,fontSize1Big,FocusOrderContent,boldOff,fontSize1Small,nextLine,

                    left,next2Line,

                    priceInfo,nextLine,

                    priceShouldPay,next2Line,

                    takeTime,nextLine,

                    setOrderTime,next2Line,

                    center,tips_1,nextLine,

                    center,tips_2,next2Line,

                    breakPartial

            };

            return byteMerger(cmdBytes);

        } catch (UnsupportedEncodingException e) {

// TODO Auto-generated catch block

            e.printStackTrace();
        }
        return null;

    }


    /**
     * 测试打印
     * @param msg
     * @return
     */
    public static byte[] printerText(String msg)
    {
        try {
            byte[] text = msg.getBytes( "gb2312");

            byte[][] cmdBytes= {
                    text,nextLine(1)
            };

            return byteMerger(cmdBytes);

        } catch (UnsupportedEncodingException e) {

// TODO Auto-generated catch block

            e.printStackTrace();
        }
        return null;

    }


    static String hen = "--------------------------------";
    static String shu  = "12345678901234567890123456789012";
    static String lan3 = "              已收       退款   ";
    static String lan  = "菜单               数量  价格   ";
    static String lan2 = "菜单               数量  积分   ";
    static String lan4 = "菜单                数量    价格";


    public static byte[] clientPaper2()
    {
        try {

            //2行

            byte[] Store_name =  "龙龙食府-花城店\n\n\n".getBytes( "gb2312");

            //2行

            byte[] Time =  "下单时间：2017-06-28 17:11:50\n".getBytes( "gb2312");

            byte[] Order_id =  "订单号：CD1ccae334b6ec120309\n".getBytes( "gb2312");

            byte[] henxian =  hen.getBytes( "gb2312");

            byte[] lanmu =  lan.getBytes( "gb2312");

            byte[] food1 =  (dataStringFoods("桂林米粉","15","150.0",32)+"\n").getBytes( "gb2312");

            byte[] attr1 =  ("<"+"薯条  可乐  小份"+">"+"\n").getBytes( "gb2312");

            //henxian

            byte[] Price_all =  "150.00\n".getBytes( "gb2312");

            byte[] Pay_type =  "支付方式：支付宝\n".getBytes( "gb2312");

            //henxian

            byte[] Order_type =  "订单类型：外带\n".getBytes( "gb2312");

            //henxian

            byte[] Take_food =  "取餐号：19001\n\n".getBytes( "gb2312");

            byte[] Pay_prompt =  "请留意小票取餐号\n".getBytes( "gb2312");

            //henxian

            byte[] Get_food_number =  "餐牌号：888\n\n".getBytes( "gb2312");

            byte[] Forward_prompt =  "前台提示语\n".getBytes( "gb2312");

            //henxian

            byte[] Pay_num =  "支付号:19628011\n\n".getBytes( "gb2312");

            byte[] Pay_prompt2 =  "凭小票，请到收银台支付\n".getBytes( "gb2312");

            //henxian

            byte[] Store_address =  "店铺地址：珠江路东888号\n".getBytes( "gb2312");

            byte[] Store_phone =  "店铺电话：18866669999\n".getBytes( "gb2312");

            byte[] Store_gong_zhong_hao =  "点餐公众号：18866669999\n".getBytes( "gb2312");

            //henxian

            byte[] Down_prompt =  "谢谢惠顾，欢迎再次光临\n".getBytes( "gb2312");

            byte[][] cmdBytes= {

                    nextLine(2),

                    alignCenter(),fontSizeSetBig(4),Store_name,

                    alignLeft(),fontSizeSetBig(1),Time,

                    Order_id,

                    henxian,

                    lanmu,

                    food1,

                    attr1,

                    henxian,

                    alignRight(),Price_all,

                    Pay_type,

                    alignLeft(),henxian,

                    alignCenter(),fontSizeSetBig(4),Order_type,

                    alignLeft(),fontSizeSetBig(1),henxian,

                    alignCenter(),fontSizeSetBig(4),Take_food,

                    fontSizeSetBig(1),Pay_prompt,

                    alignLeft(),fontSizeSetBig(1),henxian,

                    alignCenter(),fontSizeSetBig(4),Get_food_number,

                    fontSizeSetBig(1),Forward_prompt,

                    alignLeft(),fontSizeSetBig(1),henxian,

                    alignCenter(),fontSizeSetBig(4),Pay_num,

                    fontSizeSetBig(1),Pay_prompt2,

                    alignLeft(),fontSizeSetBig(1),henxian,

                    Store_address,

                    Store_phone,

                    Store_gong_zhong_hao,

                    henxian,

                    alignCenter(),Down_prompt,nextLine(6),

                    feedPaperCutPartial()
            };

            return byteMerger(cmdBytes);

        } catch (UnsupportedEncodingException e) {

// TODO Auto-generated catch block

            e.printStackTrace();
        }
        return null;

    }


    public static String CMD_SetPos()
    {
        return new StringBuffer().append((char)27).append((char)64).toString();
    }
    public static String CMC_QianXiang()
    {
        return new StringBuffer().append((char)27).append((char)112).append((char)0).append((char)60).append((char)255).toString();
    }

    public static String CMC_QianXiangTest()
    {
        return new StringBuffer().append((char)27).append((char)122).append((char)1).append((char)60).append((char)255).toString();
    }

    public  static byte[] printMoneyData(){
        String openMoney= CMC_QianXiang();
        byte[] initArray = new byte[0];
        byte[] tiArray = new byte[0];
        try {
            tiArray = openMoney.getBytes("gb2312");
            // sssArray = s1.getBytes("gb2312");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        byte[][] cmdBytes = {initArray,tiArray};
        return byteMerger(cmdBytes);
    }

//    /**
//     * 打印菜单数据
//     * @param bill
//     * @return
//     */
//    public static byte[] printerBill(Bill bill)
//    {
//        try {
//
//            LogoBean logoBean = MyTheprinter.getLOGO_ISSHOW(MyApplication.getInstance());
//
//            //2行
//            byte[] upper_bitmapData = getBitmapData(logoBean.isUpper_show(),logoBean.getUpper_url());
//
//            byte[] lower_bitmapData = getBitmapData(logoBean.isLower_show(),logoBean.getLower_url());
//
//            byte[] Store_name;
//
//            if (bill.getStore_name() != null && !bill.getStore_name().equals("") ) {
//                Store_name =  (bill.getStore_name()+"\n").getBytes( "gb2312");
//            }else {
//                Store_name =  ("").getBytes( "gb2312");
//            }
//
//            //2行
//
//            byte[] Time;
//
//            if (bill.getTime() != null && !bill.getTime().equals("")  ) {
//                if (bill.getTime().equals("cs")){
//                    Time = ("\n").getBytes("gb2312");
//                }else {
//                    Time = ("\n"+bill.getTime() + "\n").getBytes("gb2312");
//                }
//            }else {
//                Time =  ("").getBytes( "gb2312");
//            }
//
//            byte[] Order_id ;
//            byte[] henxian;
//            byte[] lanmu;
//
//            if ( bill.getOrder_id() != null && !bill.getOrder_id().equals("") ) {
//                Order_id =  (bill.getOrder_id()+"\n").getBytes( "gb2312");
//                henxian =  (hen+"\n").getBytes( "gb2312");
//                lanmu =  (lan+"\n").getBytes( "gb2312");
//
//            }else {
//                Order_id =  ("").getBytes( "gb2312");
//                henxian =  ("").getBytes( "gb2312");
//                lanmu =  ("").getBytes( "gb2312");
//            }
//
////            byte[] henxian =  (hen+"\n").getBytes( "gb2312");
////
////            byte[] lanmu =  (lan+"\n").getBytes( "gb2312");
//
//            StringBuffer sb = new StringBuffer();
//
//            if ( bill.getFoods() != null && !bill.getFoods().equals("") ) {
//                List<Bill.Foods> list = bill.getFoods();
//                for (int i = 0; i < list.size(); i++) {
//                    Bill.Foods foods = list.get(i);
//                    String food_attr = foods.getFood_attr();
//                    String food_name = foods.getFood_name();
//                    String food_num = foods.getFood_num();
//                    String food_price = foods.getFood_price();
//                    sb.append(dataStringFoods(food_name,food_num,food_price,32)+"\n");
//                    if (!food_attr.equals("")){
//                        sb.append("<"+food_attr+">"+"\n");
//                        sb.append("\n");
//                    }
//                }
//            }
//
//            byte[] food =  (sb.toString()).getBytes( "gb2312");
//
//            //henxian
//
//            byte[] Original_price ;//原价
//            if (bill.getOriginal_price() != null && !bill.getOriginal_price().equals("")){
//                Original_price = (bill.getOriginal_price()+"\n").getBytes( "gb2312");
//            }else {
//                Original_price =  ("").getBytes( "gb2312");
//            }
//
//            byte[] Preferential ;//优惠说明
//            byte[] Preferential_price ;//优惠价
//            if (bill.getPreferential() != null && !bill.getPreferential().equals("")){
//                Preferential = (bill.getPreferential()+"\n").getBytes( "gb2312");
//                Preferential_price = (bill.getPreferential_price()+"\n").getBytes( "gb2312");
//            }else {
//                Preferential =  ("").getBytes( "gb2312");
//                Preferential_price =  ("").getBytes( "gb2312");
//            }
//
//            byte[] surcharge ;//附加费
//            if ( bill.getSurcharge_price() != null && !bill.getSurcharge_price().equals("") ) {
//                surcharge =  (bill.getSurcharge_price()+"\n").getBytes( "gb2312");
//            }else {
//                surcharge =  ("").getBytes( "gb2312");
//            }
//
//            if ((bill.getSurcharge_price() == null || bill.getSurcharge_price().equals(""))
//                    &&
//                    (bill.getPreferential() == null || bill.getPreferential().equals(""))){
//                Original_price =  ("").getBytes( "gb2312");
//            }
//
//            byte[] Price_all ;//总价
//
//            if ( bill.getPrice_all() != null && !bill.getPrice_all().equals("") ) {
//                Price_all =  (bill.getPrice_all()+"\n").getBytes( "gb2312");
//            }else {
//                Price_all =  ("").getBytes( "gb2312");
//            }
//
//            byte[] Pay_type ;
//
//            if ( bill.getPay_type() != null && !bill.getPay_type().equals("") ) {
//                Pay_type =  (bill.getPay_type()+"\n").getBytes( "gb2312");
//            }else {
//                Pay_type =  ("").getBytes( "gb2312");
//            }
//
//            //henxian
//
//            byte[] Order_type ;
//            byte[] henxian2;
//
//            if ( bill.getOrder_type() != null && !bill.getOrder_type().equals("") ) {
//                Order_type =  (bill.getOrder_type()+"\n").getBytes( "gb2312");
//                henxian2 =  ("\n"+hen+"\n").getBytes( "gb2312");
//            }else {
//                Order_type =  ("").getBytes( "gb2312");
//                henxian2 =  ("").getBytes( "gb2312");
//            }
//
//            //验证码
//            byte[] cancellNum;
//            byte[] hx;
//            if (null != bill.getCancell_num() && !bill.getCancell_num().equals("")){
//                cancellNum =  ("验证码:"+bill.getCancell_num()+"\n").getBytes( "gb2312");
//                hx =  ("\n"+hen+"\n").getBytes( "gb2312");
//            }else {
//                cancellNum =  ("").getBytes( "gb2312");
//                hx =  ("").getBytes( "gb2312");
//            }
//
//            //henxian2
//
//            byte[] Take_food ;//取餐号
//
//            if ( bill.getTake_food() != null && !bill.getTake_food().equals("") ) {//
//                Take_food =  (bill.getTake_food()+"\n").getBytes( "gb2312");
//            }else {
//                Take_food =  ("").getBytes( "gb2312");
//            }
//
//            byte[] Pay_prompt ;
//            byte[] henxian3;
//
//            if (bill.getPay_prompt() != null && !bill.getPay_prompt().equals("") ) {
//                Pay_prompt =  ("\n"+bill.getPay_prompt()+"\n").getBytes( "gb2312");
//                henxian3=  (hen+"\n").getBytes( "gb2312");
//            }else {
//                Pay_prompt =  ("").getBytes( "gb2312");
//                henxian3=  ("").getBytes( "gb2312");
//            }
//
//            //henxian3
//
//            byte[] Get_food_number ;//餐牌号
//
//            if (bill.getGet_food_number() != null && !bill.getGet_food_number().equals("") ) {
//                Get_food_number =  (bill.getGet_food_number()+"\n").getBytes( "gb2312");
//            }else {
//                Get_food_number =  ("").getBytes( "gb2312");
//            }
//
//            byte[] Forward_prompt ;
//            byte[] henxian4;
//
//            if (bill.getForward_prompt() != null && !bill.getForward_prompt().equals("") ) {
//                Forward_prompt =  ("\n"+bill.getForward_prompt()+"\n").getBytes( "gb2312");
//                henxian4 = (hen+"\n").getBytes("gb2312");
//            }else {
//                Forward_prompt =  ("").getBytes( "gb2312");
//                henxian4 = ("").getBytes("gb2312");
//            }
//
//            //henxian4
//
//            byte[] Pay_num ;
//
//            if (bill.getPay_num() != null && !bill.getPay_num().equals("") ) {
//                Pay_num =  (bill.getPay_num()+"\n\n").getBytes( "gb2312");
//            }else {
//                Pay_num =  ("").getBytes( "gb2312");
//            }
//
//            byte[] Pay_prompt2 ;
//            byte[] henxian5;
//
//            if (bill.getPay_prompt2() != null && !bill.getPay_prompt2().equals("") ) {
//                Pay_prompt2 =  (bill.getPay_prompt2()+"\n").getBytes( "gb2312");
//                henxian5 = (hen+"\n").getBytes("gb2312");
//            }else {
//                Pay_prompt2 =  ("").getBytes( "gb2312");
//                henxian5 = ("").getBytes("gb2312");
//            }
//
//            //henxian5
//
//            byte[] Store_address ;
//
//            if (bill.getStore_address() != null && !bill.getStore_address().equals("") ) {
//                Store_address =  (bill.getStore_address()+"\n").getBytes( "gb2312");
//            }else {
//                Store_address =  ("").getBytes( "gb2312");
//            }
//
//            byte[] Store_phone ;
//
//            if (bill.getStore_phone() != null && !bill.getStore_phone().equals("") ) {
//                Store_phone =  (bill.getStore_phone()+"\n").getBytes( "gb2312");
//            }else {
//                Store_phone =  ("").getBytes( "gb2312");
//            }
//
//            byte[] Store_out_sell_phone;
//            if (bill.getStore_out_sell_phone() != null && !bill.getStore_out_sell_phone().equals("")){
//                Store_out_sell_phone =  (bill.getStore_out_sell_phone()+"\n").getBytes( "gb2312");
//            }else {
//                Store_out_sell_phone =  ("").getBytes( "gb2312");
//            }
//
//            byte[] Store_gong_zhong_hao ;
//
//            if (bill.getStore_gong_zhong_hao() != null && !bill.getStore_gong_zhong_hao().equals("") ) {
//                Store_gong_zhong_hao =  (bill.getStore_gong_zhong_hao()+"\n").getBytes( "gb2312");
//            }else {
//                Store_gong_zhong_hao =  ("").getBytes( "gb2312");
//            }
//
//            byte[] henxian6 ;
//
//            if (Store_address.length == 0 && Store_phone.length == 0 && Store_gong_zhong_hao.length == 0){
//                henxian6 = ("").getBytes("gb2312");
//            }else {
//                henxian6 = (hen+"\n").getBytes("gb2312");
//            }
//
//            //henxian6
//
//            byte[] Down_prompt ;
//
//            if ( bill.getDown_prompt() != null && !bill.getDown_prompt().equals("")) {
//                Down_prompt =  (bill.getDown_prompt()+"\n\n").getBytes( "gb2312");
//            }else {
//                Down_prompt = ("").getBytes("gb2312");
//            }
//
//            byte[] end;
//            if (bill.getTime().equals("cs")) {//测试USB的
//                upper_bitmapData = ("").getBytes("gb2312");
//                lower_bitmapData = ("").getBytes("gb2312");
//                end = ("").getBytes("gb2312");
//            }else {
//                end = ("\n\n\n").getBytes("gb2312");
//            }
//
//            byte[][] cmdBytes= {
//
//                    nextLine(1),
//
//                    upper_bitmapData,
//
//                    alignCenter(),fontSizeSetBig(4),Store_name,
//
//                    alignLeft(),fontSizeSetBig(1),Time,
//
//                    Order_id,
//
//                    henxian,
//
//                    lanmu,
//
//                    food,
//
//                    henxian,
//
//                    alignRight(),
//                    /************* 0805 **************/
//                    Original_price,
//                    Preferential,
//                    Preferential_price,
//                    /************* 0805 **************/
//                    surcharge,
//                    Price_all,
//
//                    Pay_type,
//
//                    alignLeft(),henxian,
//
//                    alignCenter(),fontSizeSetBig(4),Order_type,
//
//                    alignLeft(),fontSizeSetBig(1),henxian2,
//
//                    alignCenter(),fontSizeSetBig(4),cancellNum,
//
//                    alignLeft(),fontSizeSetBig(1),hx,
//
//                    alignCenter(),fontSizeSetBig(4),Take_food,
//
//                    fontSizeSetBig(1),Pay_prompt,
//
//                    alignLeft(),fontSizeSetBig(1),henxian3,
//
//                    alignCenter(),fontSizeSetBig(4),Get_food_number,
//
//                    fontSizeSetBig(1),Forward_prompt,
//
//                    alignLeft(),fontSizeSetBig(1),henxian4,
//
//                    alignCenter(),fontSizeSetBig(4),Pay_num,
//
//                    fontSizeSetBig(1),Pay_prompt2,
//
//                    alignLeft(),fontSizeSetBig(1),henxian5,
//
//                    Store_address,
//
//                    Store_phone,
//
//                    Store_out_sell_phone,
//
//                    Store_gong_zhong_hao,
//
//                    henxian6,
//
//                    alignCenter(),Down_prompt,
//
//                    lower_bitmapData,
//
//                    end,
//
//                    feedPaperCutPartial()
//            };
//
//            return byteMerger(cmdBytes);
//
//        } catch (UnsupportedEncodingException e) {
//
//// TODO Auto-generated catch block
//
//            e.printStackTrace();
//        }
//        return null;
//
//    }

//    /**
//     * 统计
//     * @param bean
//     * @return
//     */
//    public static byte[] printerTongji(TongJiBean bean){
//        try {
//
//            byte[] Headname = (bean.getHeadname()+"\n").getBytes("gb2312");
//
//            StringBuffer sb = new StringBuffer();
//
//            sb.append("\n");
//            sb.append(bean.getUsername()+"\n");
//            sb.append(bean.getDate()+"\n");
//            sb.append(bean.getTime()+"\n");
//            sb.append(hen+"\n");
//            if (bean.getType().equals("0")){
////                sb.append(lan3+"\n");
//            }else {
//                sb.append(juZhong2("主菜统计",32)+"\n");
////                sb.append(zuoBian2("测试avb",14)+juZhong2("",1)+youBian2("10份",16));//
////                sb.append(zuoBian2("测试(不意)",14)+juZhong2("",1)+youBian2("10份",16));//
////                sb.append(zuoBian2("测试（在意）",14)+juZhong2("",1)+youBian2("10份",16));//
//            }
//            if (bean.getYyeDateList() != null && bean.getYyeDateList().size() != 0){
//                List<TongJiBean.YYEDate> yyeDateList = bean.getYyeDateList();
//                for (int i = 0; i < yyeDateList.size(); i++) {
//                    TongJiBean.YYEDate yyeDate = yyeDateList.get(i);
//
//                    if (i == yyeDateList.size() - 5){
//                        sb.append(hen+"\n");
//                        sb.append(zuoBian2("",5)+juZhong2(yyeDate.getPayType(),10)+youBian2(yyeDate.getTuikuan(),16)+"\n");
//                    }else if (i > yyeDateList.size() - 5 && i < yyeDateList.size() - 1){
//                        sb.append(zuoBian2("",5)+juZhong2(yyeDate.getPayType(),10)+youBian2(yyeDate.getTuikuan(),16)+"\n");
//                    } else if (i == yyeDateList.size() - 1){
//                        sb.append(zuoBian2("",5)+juZhong2(yyeDate.getPayType(),10)+youBian2(yyeDate.getTuikuan(),16)+"\n");
//                        sb.append(hen+"\n");
//                    }else {
//                        sb.append(zuoBian2(yyeDate.getPayType(),14)+juZhong2(yyeDate.getYinshou(),1)+youBian2(yyeDate.getTuikuan(),16)+"\n");
//                    }
//
//
////                    if ( i == yyeDateList.size() - 3 ){//i == yyeDateList.size() - 1
////                        sb.append(hen+"\n");
////                        sb.append(zuoBian2("",5)+juZhong2(yyeDate.getPayType(),10)+youBian2(yyeDate.getTuikuan(),16)+"\n");
////                    }else if (i == yyeDateList.size() - 2){
////                        sb.append(zuoBian2("",5)+juZhong2(yyeDate.getPayType(),10)+youBian2(yyeDate.getTuikuan(),16)+"\n");
////                    }else if (i == yyeDateList.size() - 1){
////                        sb.append(zuoBian2("",5)+juZhong2(yyeDate.getPayType(),10)+youBian2(yyeDate.getTuikuan(),16)+"\n");
////                        sb.append(hen+"\n");
////                    } else {
////                        sb.append(zuoBian2(yyeDate.getPayType(),14)+juZhong2(yyeDate.getYinshou(),1)+youBian2(yyeDate.getTuikuan(),16)+"\n");
////                    }
//
//
//                }
//            }
//            if (bean.getCpDateList() != null && bean.getCpDateList().size() != 0){
//                List<TongJiBean.CPDate> cpDateList = bean.getCpDateList();
//                for (int i = 0; i < cpDateList.size(); i++) {
//                    TongJiBean.CPDate cpDate = cpDateList.get(i);
//                    sb.append(zuoBian2(cpDate.getCpname(),18)+youBian2(cpDate.getCpnum(),14));
//                    if (i == cpDateList.size() - 1 && bean.getType().equals("0")){
//                        sb.append(hen + "\n");
//                        sb.append("\n");
//                        sb.append("签名：" + "\n");
//                    }
//                }
//            }
//            if (bean.getShDateList() != null && bean.getShDateList().size() != 0){
//                sb.append(hen + "\n");
//                sb.append(juZhong2("规格属性统计",32));
//                List<TongJiBean.SXDate> sxDateList = bean.getShDateList();
//                for (int i = 0; i < sxDateList.size(); i++) {
//                    TongJiBean.SXDate sxDate = sxDateList.get(i);
//                    sb.append(zuoBian2(sxDate.getSxname(),18)+youBian2(sxDate.getSxnum(),14));
//                }
//            }
//
//            sb.append("\n");
//
//            byte[] data = sb.toString().getBytes("gb2312");
//
//            byte[][] cmdBytes= {
//
//                    nextLine(1),
//
//                    alignCenter(),fontSizeSetBig(4),Headname,
//
//                    alignLeft(),fontSizeSetBig(1),data,
//
//                    nextLine(3),
//
//                    feedPaperCutPartial()
//
//            };
//
//            return byteMerger(cmdBytes);
//
//        } catch (UnsupportedEncodingException e) {
//
//// TODO Auto-generated catch block
//
//            e.printStackTrace();
//        }
//        return null;
//
//    }
//
//    /**
//     * 兑换
//     * @param bean
//     * @return
//     */
//    public static byte[] printerDuiHuan(DuiHuanBean bean){
//        try {
//
//            byte[] Headname;
//
//            if (bean.getStore_name() != null && !bean.getStore_name().equals("") ) {
//                Headname = (bean.getStore_name()+"\n").getBytes("gb2312");
//            }else {
//                Headname = ("").getBytes("gb2312");
//            }
//
//            StringBuffer sb = new StringBuffer();
//
//            sb.append("\n");
//
//            if (bean.getAdd_time() != null && !bean.getAdd_time().equals("")  ) {
//                sb.append(bean.getAdd_time()+"\n");
//
//            }
//            if (bean.getOrder_sn() != null && !bean.getOrder_sn().equals("") ) {
//                sb.append(bean.getOrder_sn()+"\n");
//
//            }
//            sb.append(hen+"\n");
//            sb.append(lan2+"\n");
//            sb.append(dataStringFoods(bean.getGoods_name(),bean.getGoods_num(),bean.getScore(),32)+"\n");
//            sb.append(hen+"\n");
//            sb.append(youBian(bean.getType(),32)+"\n");
//            sb.append(hen+"\n");
//            if (bean.getStore_address() != null && !bean.getStore_address().equals("")  ) {
//                sb.append(bean.getStore_address()+"\n");
//            }
//
//            if (bean.getStore_phone() != null && !bean.getStore_phone().equals("")  ) {
//                sb.append(bean.getStore_phone()+"\n");
//            }
//
//            if (bean.getStore_gong_zhong_hao() != null && !bean.getStore_gong_zhong_hao().equals("") ) {
//                sb.append(bean.getStore_gong_zhong_hao()+"\n");
//                sb.append(hen+"\n");
//            }
//
//            if (bean.getDown_prompt() != null && !bean.getDown_prompt().equals("")  ) {
////            sb.append(StringUtils.getStringToCenter(bean.getDown_prompt(),line)+"\n");
//                sb.append(juZhong(bean.getDown_prompt(),32)+"\n");
//            }
//            sb.append("\n\n\n");
//
//            byte[] data = sb.toString().getBytes("gb2312");
//
//            byte[][] cmdBytes= {
//
//                    nextLine(1),
//
//                    alignCenter(),fontSizeSetBig(4),Headname,
//
//                    alignLeft(),fontSizeSetBig(1),data,
//
//                    feedPaperCutPartial()
//
//            };
//
//            return byteMerger(cmdBytes);
//
//        } catch (UnsupportedEncodingException e) {
//
//// TODO Auto-generated catch block
//
//            e.printStackTrace();
//        }
//        return null;
//
//    }

//    public static byte[] printMeiTuan(MTDYBean bean){
//        try {
//
//            //2行
//            byte[] henx = (hen+"\n").getBytes("gb2312");
//
//            byte[] poi_name = (bean.getWm_poi_name()+"\n\n").getBytes("gb2312");
//
//            byte[] meituan = (bean.getMeituan()+"\n\n").getBytes("gb2312");
//
//            byte[] num =  (bean.getDay_seq()+"\n\n").getBytes( "gb2312");
//
//            byte[] type =  (bean.getPayType()+"\n\n").getBytes( "gb2312");
//
//            byte[] Time =  ((bean.getCtime())+"\n").getBytes( "gb2312");
//
//            byte[] yuji;
//            if (!bean.getDelivery_time().equals("0")) {
//                yuji =  ("指定送达时间:"+bean.getDelivery_time()+"\n").getBytes( "gb2312");
//            }else {
//                yuji =  ("").getBytes( "gb2312");
//            }
//
//            byte[] lan = (lan4+"\n").getBytes( "gb2312");
//
//            StringBuffer sb = new StringBuffer();
//            List<DetailElement> detail = bean.getDetail();
//            for (int i = 0; i <detail.size(); i++) {
//                DetailElement element = detail.get(i);
//                if (element.getSpec() == null || element.getSpec().equals("")) {
//                    sb.append(dataStringSet3(element.getFood_name(),"x"+element.getQuantity(),element.getPrice(),32,0)+"\n");
//                }else {
//                    sb.append(dataStringSet3(element.getFood_name()+"("+element.getSpec()+")","x"+element.getQuantity(),element.getPrice(),32,0)+"\n");
//                }
//                if (!TextUtils.isEmpty(element.getFood_property())) {
//                    sb.append("<" + element.getFood_property() + ">"+"\n");
//                }
//            }
//
//            byte[] foods = sb.toString().getBytes( "gb2312");
//
//            byte[] box_alls = (dataStringSet3("餐盒费", "", bean.getBox_alls(), 32, 0) + "\n").getBytes("gb2312");
//
//            byte[] ship_free = (dataStringSet3("配送费", "", bean.getShipping_fee(), 32, 0) + "\n").getBytes("gb2312");
//
//            byte[] original_price = (dataStringSet3("原价", "", bean.getOriginal_price(), 32, 0) + "").getBytes("gb2312");
//
//            StringBuffer buffer = new StringBuffer();
//            List<ExtrasElement> extras = bean.getExtras();
//            for (int i = 0; i < extras.size(); i++) {
//                ExtrasElement element = extras.get(i);
//                if (!TextUtils.isEmpty(element.getRemark()) && !TextUtils.isEmpty(element.getReduce_fee())) {
//                    buffer.append(dataStringSet3(element.getRemark(), "", "-"+element.getReduce_fee(), 32, 0)+"\n");
//                }
//            }
//
//            String s = buffer.toString();
//            byte[] youhui = s.getBytes("gb2312");
//            byte[] henx2 ;
//            if (!TextUtils.isEmpty(s)){
//                henx2 = hen.getBytes("gb2312");
//            }else {
//                henx2 = "".getBytes("gb2312");
//            }
//
//            byte[] total = (dataStringSet3("实际支付", "", bean.getTotal() + "元", 32, 0) + "\n").getBytes("gb2312");
//
//            byte[] adrss = "送达地址：".getBytes("gb2312");
//
//            byte[] reci_adress_name = (bean.getRecipient_address() + "," + bean.getRecipient_name() + "\n").getBytes("gb2312");
//
//            byte[] phone = (bean.getRecipient_phone() + "\n\n").getBytes("gb2312");
//
//            byte[] beizhu = "备注：".getBytes("gb2312");
//
//            byte[] caution = (bean.getCaution() + "\n\n").getBytes("gb2312");
//
//            byte[] language = (bean.getBill_foot_language() + "\n").getBytes("gb2312");
//
//            byte[][] cmdBytes= {
//
//                    nextLine(1),
//
//                    alignCenter(),fontSizeSetBig(4),boldOn(),
//                    poi_name ,
//                    meituan,
//                    num,
//                    type,
//
//                    alignLeft(),fontSizeSetBig(1),boldOff(),
//                    Time,
//                    yuji,
//                    henx,
//                    lan,
//
//                    fontSizeSetBig(2),
//                    foods,
//
//                    fontSizeSetBig(1),
//                    henx,
//                    box_alls,
//                    ship_free,
//                    henx,
//                    original_price,
//                    henx,
//                    youhui,
//                    henx2,
//
//                    fontSizeSetBig(2),
//                    total,
//
//                    fontSizeSetBig(1),
//                    henx,
//
//                    fontSizeSetBig(2),
//                    adrss,
//
//                    fontSizeSetBig(4),boldOn(),
//                    reci_adress_name,
//                    phone,
//
//                    fontSizeSetBig(2),boldOff(),
//                    beizhu,
//
//                    fontSizeSetBig(4),boldOn(),
//                    caution,
//
//                    alignCenter(),fontSizeSetBig(1),boldOff(),
//                    language,
//
//                    nextLine(3),
//                    feedPaperCutPartial()
//            };
//
//            return byteMerger(cmdBytes);
//
//        } catch (UnsupportedEncodingException e) {
//
//// TODO Auto-generated catch block
//
//            e.printStackTrace();
//        }
//        return null;
//    }

    static String totlePrices="                     总价：";
    static String payttts     ="                 支付方式：";

//    /**
//     * 退款的打印模板
//     * @param bean
//     * @param title
//     * @return
//     */
//    public static byte[] printDuiCai(DataBean bean, String title) {
//
//        try {
//            byte[] Headname = (bean.getRestaurant_name()+"\n").getBytes("gb2312");
//
//            byte[] btitle = ("\n"+"--- "+title+" ---"+"\n\n").getBytes("gb2312");
//
//            DateTime time = new DateTime(Long.valueOf(bean.getAdd_time()) * 1000);
//            byte[] btime = ("下单时间：" + time.toString("yyyy-MM-dd HH:mm:ss") + "\n").getBytes("gb2312");
//
//            byte[] zhifuhao = ("支付号  :" + bean.getZhifuhao()+"\n").getBytes("gb2312");
//
//            byte[] henx = (hen+"\n").getBytes("gb2312");
//
//            byte[] lanx = (lan+"\n").getBytes( "gb2312");
//
//            StringBuffer sb = new StringBuffer();
//            String allPrice = "0";
//
//            if ( bean.getFood_list() != null && bean.getFood_list().size() != 0 ) {
//                List<FoodListBean> list = bean.getFood_list();
//                for (int i = 0; i < list.size(); i++) {
//                    FoodListBean foods = list.get(i);
//
//                    List<FoodAttributeBean> food_attribute = foods.getFood_attribute();
//                    String food_name = foods.getFood_name();
//                    String food_num = foods.getFood_num();
//                    String food_price = foods.getFood_price2();
//
//                    //计算总价
//                    BigDecimal bigDecimal= new BigDecimal(allPrice);
//                    BigDecimal bigDecima2 = new BigDecimal(food_price);
//                    BigDecimal bigDecima3 = bigDecimal.add(bigDecima2).setScale(2, BigDecimal.ROUND_HALF_UP);
//                    allPrice = bigDecima3.toPlainString();
//
////                    allPrice += Float.valueOf(food_price);
//
//                    sb.append(dataStringFoods(food_name,food_num,food_price,32)+"\n");
//                    StringBuffer food_attr = new StringBuffer();
//                    for (int j = 0; j < food_attribute.size(); j++) {
//                        FoodAttributeBean foodAttributeBean = food_attribute.get(j);
//                        food_attr.append(foodAttributeBean.getFood_attribute_name() +" ");
//                    }
//                    if (!food_attr.equals(" ")){
//                        sb.append("<"+food_attr+">"+"\n");
//                        sb.append("\n");
//                    }
//                }
//            }
//
//            byte[] food =  (sb.toString()).getBytes( "gb2312");
//            //横线
//            BigDecimal allPrice2 = new BigDecimal(allPrice);
//            BigDecimal total = new BigDecimal(bean.getTotal_amount());
//            byte[] zongjia = ("总价:"+total.toPlainString()+"\n").getBytes("gb2312");
//            int num = CommonUtil.compareStringInDecimal(allPrice2.toPlainString(), total.toEngineeringString());
//            byte[] yuanjia;
//            if (num == 0) {
//                yuanjia = ("").getBytes("gb2312");
//            }else {
//                yuanjia = ("原价:" + allPrice2.toPlainString() + "\n").getBytes("gb2312");
//            }
//            String syouhui = CommonUtil.minus(allPrice2.toPlainString(), total.toEngineeringString());
//            byte[] youhui;
//            youhui = ("").getBytes("gb2312");
//            //计算优惠和附加费，先不处理
////            if (num == 0) {
////                youhui = ("").getBytes("gb2312");
////            }else if (num < 0){
////                youhui = ("优惠:" + syouhui + "\n").getBytes("gb2312");
////            }else if (num > 0){
////                youhui = ("附加费:" + syouhui + "\n").getBytes("gb2312");
////            }
//
//            String type = bean.getPay_type();//（0现金，1支付宝，2微信，3未支付,4余额，5第四方支付）
//            String patype="";
//            switch (type){
//                case "0":
//                    patype="现金";
//                    break;
//                case "1":
//                    patype="支付宝";
//                    break;
//                case "2":
//                    patype="微信";
//                    break;
//                case "3":
//                    patype="未支付";
//                    break;
//                case "4":
//                    patype="余额";
//                    break;
//                case "5":
//                    patype="第四方支付";
//                    break;
//            }
//            byte[] pay_type = ("支付方式:"+patype+"\n").getBytes("gb2312");
//            //横线
//            String etype = "";
//            String order_type = bean.getOrder_type();//'就餐方式（1店吃，2打包带走，3微信外卖）'
//            switch (order_type){
//                case "1":
//                    etype = "堂吃";
//                    break;
//                case "2":
//                    etype = "外带";
//                    break;
//                case "3":
//                    etype = "微信外卖";
//                    break;
//            }
//            Log.d("tuicaidayin", "printDuiCai: "+etype);
//            byte[] eat_type = ("订单类型:"+etype+"\n").getBytes("gb2312");
//            //横线
//            byte[] take_num = ("取餐号:"+bean.getTake_num()+"\n").getBytes("gb2312");
//            //横线
//            byte[] address = ("店铺地址："+bean.getAddress()+"\n").getBytes("gb2312");
//
//            byte[] telephone1 = ("店铺电话："+bean.getTelephone1()+"\n").getBytes("gb2312");
//
//
////            StringBuffer sb = new StringBuffer();
//////        sb.append(juZhong(bean.getRestaurant_name(),32)+"\n");
////            sb.append("\n"+"--------------"+title+"--------------").append("\n\n");
////            sb.append("下单时间：" + time.toString("yyyy-MM-dd HH:mm:ss") + "\n");
////            sb.append("支付号  :" + bean.getZhifuhao()+"\n")
////                    .append(hen + "\n")
////                    .append(lan + "\n");
////            float totlePrice=0;
////            for (FoodListBean foods : bean.getFood_list()) {
////                totlePrice+=Float.valueOf(foods.getFood_price2());
////                sb.append(dataStringFoods(foods.getFood_name(), foods.getFood_num(), foods.getFood_price2(), 32) + "\n");
////                sb.append("<");
////                for (FoodAttributeBean attrs : foods.getFood_attribute()) {
////                    sb.append(attrs.getFood_attribute_name()+"  ");
////                }
////                sb.append(">\n");
////            }
////            sb.append(hen + "\n");
////            sb.append(totlePrices+totlePrice+"\n");
////            String type = bean.getPay_type();//（0现金，1支付宝，2微信，3未支付,4余额，5第四方支付）
////            String patype="";
////            switch (type){
////                case "0":
////                    patype="现金";
////                    break;
////                case "1":
////                    patype="支付宝";
////                    break;
////                case "2":
////                    patype="微信";
////                    break;
////                case "3":
////                    patype="未支付";
////                    break;
////                case "4":
////                    patype="余额";
////                    break;
////                case "5":
////                    patype="第四方支付";
////                    break;
////            }
////            sb.append(payttts+patype+"\n");
////            sb.append(hen+"\n");
////            StringBuffer ddlx=new StringBuffer("订单类型：");
////            String type2 = bean.getOrder_type();//'就餐方式（1店吃，2打包带走，3微信外卖）'
////            switch (type2){
////                case "1":
////                    ddlx.append("堂吃");
////                    break;
////                case "2":
////                    ddlx.append("外带");
////                    break;
////                case "3":
////                    ddlx.append("微信外卖");
////                    break;
////            }
////            sb.append(juZhong(ddlx.toString(),32)+"\n");
////            sb.append(hen+"\n");
////            sb.append(juZhong("取餐号："+bean.getTake_num(),32)+"\n");
//////        sb.append(StringUtils.getStringToCenter(bean.get,line)+"\n")
////            sb.append(hen+"\n");
////            sb.append("店铺地址："+bean.getAddress()+"\n");
////            sb.append("店铺电话："+bean.getTelephone1()+"\n");
////            sb.append("\n\n\n");
////
////            byte[] data = sb.toString().getBytes("gb2312");
//            byte[][] cmdBytes= {
//
////                    nextLine(1),
////
////                    alignCenter(),fontSizeSetBig(4),Headname,
////
////                    alignLeft(),fontSizeSetBig(1),data,
////
////                    feedPaperCutPartial()
//
//                    nextLine(1),
//
//                    alignCenter(),
//                    fontSizeSetBig(4),Headname,
//                    btitle,
//
//                    fontSizeSetBig(1),
//                    alignLeft(),
//                    btime,zhifuhao,henx,
//                    lanx,food,henx,
//
//                    alignRight(),
//                    yuanjia,youhui,zongjia,pay_type,henx,
//
//                    alignCenter(),fontSizeSetBig(4),eat_type,
//                    alignLeft(),fontSizeSetBig(1),henx,
//
//                    alignCenter(),fontSizeSetBig(4),take_num,
//                    alignLeft(),fontSizeSetBig(1),henx,
//
//                    address,telephone1,
//                    nextLine(3),
//                    feedPaperCutPartial()
//
//            };
//
//            return byteMerger(cmdBytes);
//        } catch (UnsupportedEncodingException e) {
//            e.printStackTrace();
//        }
//
//        return null;
//    }


    /**
     * 美团算法
     * @param food_name
     * @param food_num
     * @param food_price
     * @param num
     * @param size
     * @return
     */
    public static String dataStringSet3(String food_name, String food_num, String food_price, int num, int size) {
        String result = null;
        StringBuffer sb = new StringBuffer();
        char[] name_arr = food_name.toCharArray();//字符數
        Log.d("abcd", "name_arr: "+name_arr.length);
        char[] num_arr = food_num.toCharArray();
        Log.d("abcd", "num_arr: "+num_arr.length);
        char[] price_arr = food_price.toCharArray();
        Log.d("abcd", "num_arr: "+price_arr.length);

        //菜品
        sb.append(food_name);
        int znum = 0;
        for (int i = 0; i < name_arr.length; i++) {
            if (isZhongWen(name_arr[i])){
                znum++;//中文個數
            }
        }

        int kong = 18- 2*znum - (name_arr.length - znum)*1;

        for (int i = 0; i < kong; i++) {
            sb.append(" ");
        }

        //数量
        znum = 0;
        kong = 0;
        for (int i = 0; i < num_arr.length; i++) {
            if (isZhongWen(num_arr[i])){
                znum++;//中文個數
            }
        }
        kong = 6- 2*znum - (num_arr.length - znum)*1;

        for (int i = 0; i < kong; i++) {
            sb.append(" ");
        }
        sb.append(food_num);

        //价格
        znum = 0;
        kong = 0;
        for (int i = 0; i < price_arr.length; i++) {
            if (isZhongWen(price_arr[i])){
                znum++;//中文個數
            }
        }
        kong = 8- 2*znum - (price_arr.length - znum)*1;

        for (int i = 0; i < kong; i++) {
            sb.append(" ");
        }
        sb.append(price_arr);

        result = sb.toString();
        return result;
    }

    /**
     * 菜品
     * @param food_name
     * @param food_num
     * @param food_price
     * @param num
     * @return
     */
    public static String dataStringFoods(String food_name, String food_num, String food_price, int num ) {
        String result = null;
        StringBuffer sb = new StringBuffer();
        try {

            char[] name_arr = food_name.toCharArray();//字符數
            Log.d("abcd", "name_arr: "+name_arr.length);
            char[] num_arr = food_num.toCharArray();
            Log.d("abcd", "num_arr: "+num_arr.length);
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
                            if (isZhongWen(chars[j])){
                                znum++;//中文個數
                            }
                        }
                        Log.d("dataStringSet2", "znum: "+znum);
                        for (int j = 0; j < 9-znum; j++) {
                            //一個中文占2位，數字占1位
                            sb.append(" ");//40-4*znum =
                        }
//                        sb.append(" ");
                        i = 20;
                    }
                    else {
                        int zhongwen = 0;
                        for (int j = 0; j < name_arr.length; j++) {
                            sb.append(name_arr[j]);
                            if (isZhongWen(name_arr[j])){
                                zhongwen ++;
                            }
                        }
                        i = zhongwen*2 + name_arr.length-zhongwen;
                        Log.d("dataStringSet2", "dataStringSet2: i--->"+i);
//                        sb.append(" ");

                    }
                } else if (i == 22) {
                    for (int j = 0; j < num_arr.length; j++) {
                        sb.append(num_arr[j]);
                        i++;
                    }
                }else if (i == 26){
                    for (int j = 0; j < price_arr.length; j++) {
                        sb.append(price_arr[j]);
                        i++;
                    }
                } else {
                    sb.append(" ");
                }
            }
            result = sb.toString();
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

//    // 根据UnicodeBlock方法判断中文标点符号
//    public static boolean  isZhongWen(char name){
//        if (isChinesePunctuation(name)){
//            Log.d("222isZhongWen", "isZhongWen: "+name);
//            return true;
//        }else if((name >= 0x4e00)&&(name <= 0x9fcc)) {//0x9fbb
//            return  true;
//        }
////        else if (isChinesePunctuation(name)){
////            Log.d("222isZhongWen", "isZhongWen: "+name);
////            return true;
////        }
//        return false;
//    }

    /**
     * 根据Unicode编码判断中文汉字和符号
     * 判断中文汉字和符号
     * @param c
     * @return
     */
    public static boolean isZhongWen(char c) {
        Character.UnicodeBlock ub = Character.UnicodeBlock.of(c);
        if (ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS
                || ub == Character.UnicodeBlock.CJK_COMPATIBILITY_IDEOGRAPHS
                || ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS_EXTENSION_A
                || ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS_EXTENSION_B
                || ub == Character.UnicodeBlock.CJK_SYMBOLS_AND_PUNCTUATION
                || ub == Character.UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS
                || ub == Character.UnicodeBlock.GENERAL_PUNCTUATION) {
            Log.d("222isZhongWen", "isZhongWen: "+c);
            return true;
        }
        return false;
    }

    // 根据UnicodeBlock方法判断中文标点符号
    @RequiresApi(api = Build.VERSION_CODES.KITKAT)
    public static boolean isChinesePunctuation(char c) {
        Character.UnicodeBlock ub = Character.UnicodeBlock.of(c);
        if (ub == Character.UnicodeBlock.GENERAL_PUNCTUATION
                || ub == Character.UnicodeBlock.CJK_SYMBOLS_AND_PUNCTUATION
                || ub == Character.UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS
                || ub == Character.UnicodeBlock.CJK_COMPATIBILITY_FORMS
                || ub == Character.UnicodeBlock.VERTICAL_FORMS) {
            return true;
        } else {
            return false;
        }
    }




    //居中2
    public static String juZhong2(String str, int num){
        char[] chars = str.toCharArray();//字符數
        StringBuffer sb = new StringBuffer();
        int zhongwenNum = 0;
        for (int i = 0; i < chars.length; i++) {
            if (isZhongWen(chars[i])) {
                zhongwenNum++;
            }
        }
        int left = (num - 2 * zhongwenNum - (chars.length - zhongwenNum)) / 2;
        int you = num - left - 2 * zhongwenNum - (chars.length - zhongwenNum);
        for (int i = 0; i < left; i++) {
            sb.append(" ");
        }
        sb.append(str);
        for (int i = 0; i < you; i++) {
            sb.append(" ");
        }
        return sb.toString();
    }

    //居左2
    public static String zuoBian2(String str, int num){//最多9个中文 18
        char[] chars = str.toCharArray();//字符數
        StringBuffer sb = new StringBuffer();
        int zhongwenNum = 0;
        for (int i = 0; i < chars.length; i++) {
            if (isZhongWen(chars[i])) {
                zhongwenNum++;
            }
        }

        int chaochu = zhongwenNum * 2 + (chars.length - zhongwenNum) - num;
        //超出num 的字节数
        if (chaochu > 0){
            int k = num / 2 + 1;
            for (int i = 0; i < k; i++) {
                if (i == k - 2 || i == k - 3 ) {
                    sb.append(".");
                }else {
                    sb.append(chars[i]);
                }
            }
            String s = sb.toString();
            char[] charArray = s.toCharArray();
            zhongwenNum = 0;
            for (int i = 0; i < charArray.length; i++) {
                if (isZhongWen(charArray[i])) {
                    zhongwenNum++;
                }
            }
            int you = num - 2 * zhongwenNum - (charArray.length - zhongwenNum);
            for (int i = 0; i < you; i++) {
                sb.append(" ");
            }

        }else {
            int you = num - 2 * zhongwenNum - (chars.length - zhongwenNum);
            sb.append(str);
            for (int i = 0; i < you; i++) {
                sb.append(" ");
            }
        }
        return sb.toString();
    }

    //居右2
    public static String youBian2(String str, int num){//最多7个中文 12345.7元
        char[] chars = str.toCharArray();//字符數
        Log.d("youBian2youBian2", "youBian2: "+chars.length+","+num);
        StringBuffer sb = new StringBuffer();
        int zhongwenNum = 0;
        for (int i = 0; i < chars.length; i++) {
            if (isZhongWen(chars[i])) {
                zhongwenNum++;
            }
        }
        int left = num - 2 * zhongwenNum  - (chars.length - zhongwenNum);
        Log.d("youBian2youBian2", "left: "+left);
        for (int i = 0; i < left; i++) {
            sb.append(" ");
        }
        sb.append(str);
        return sb.toString();
    }

    public static String juZhong(String str, int num){
        char[] chars = str.toCharArray();//字符數
        StringBuffer sb = new StringBuffer();
        int zhongwenNum = 0;
        for (int i = 0; i < chars.length; i++) {
            if (isZhongWen(chars[i])) {
                zhongwenNum++;
            }
        }
        int left = (num - 2 * zhongwenNum - (chars.length - zhongwenNum)) / 2;
        for (int i = 0; i < left; i++) {
            sb.append(" ");
        }
        sb.append(str);
        return sb.toString();
    }

    public static String youBian(String str, int num){
        char[] chars = str.toCharArray();//字符數
        StringBuffer sb = new StringBuffer();
        int zhongwenNum = 0;
        for (int i = 0; i < chars.length; i++) {
            if (isZhongWen(chars[i])) {
                zhongwenNum++;
            }
        }
        int left = num - 2 * (zhongwenNum + 1 ) - (chars.length - zhongwenNum);
        for (int i = 0; i < left; i++) {
            sb.append(" ");
        }
        sb.append(str);
        return sb.toString();
    }

    public static byte[] getBitmapData(boolean is_show, String img_url){

        Bitmap logo_bitmap;
        if (is_show && !img_url.equals("")){
//            logo_bitmap = Mydownload.getBitmap(img_url, 120, 120);
            logo_bitmap = null;
        }else {
            logo_bitmap = null;
        }

        byte[] printBitmap = printBitmap(logo_bitmap);
        if (logo_bitmap != null && logo_bitmap.isRecycled()){
            logo_bitmap.recycle();
        }
        return printBitmap;
    }

    public static byte[] printBitmap(Bitmap bmp) {
        if (bmp == null) {
            byte[] bytes = "".getBytes();
            return bytes;
        }
        bmp = compressPic(bmp);
        byte[] bmpByteArray = draw2PxPoint(bmp);
        return bmpByteArray;
    }

    /**
     * 对图片进行压缩（去除透明度）
     *
     * @param bitmapOrg
     */
    private static Bitmap compressPic(Bitmap bitmapOrg) {
        // 获取这个图片的宽和高
        int width = bitmapOrg.getWidth();
        int height = bitmapOrg.getHeight();
        // 定义预转换成的图片的宽度和高度
        int newWidth = 150;
        int newHeight = 150;
        Bitmap targetBmp = Bitmap.createBitmap(newWidth, newHeight, Bitmap.Config.ARGB_8888);
        Canvas targetCanvas = new Canvas(targetBmp);
        targetCanvas.drawColor(0xffffffff);
        targetCanvas.drawBitmap(bitmapOrg, new Rect(0, 0, width, height), new Rect(0, 0, newWidth, newHeight), null);
        return targetBmp;
    }


    /*************************************************************************
     * 假设一个360*360的图片，分辨率设为24, 共分15行打印 每一行,是一个 360 * 24 的点阵,y轴有24个点,存储在3个byte里面。
     * 即每个byte存储8个像素点信息。因为只有黑白两色，所以对应为1的位是黑色，对应为0的位是白色
     **************************************************************************/
    private static byte[] draw2PxPoint(Bitmap bmp) {
        //先设置一个足够大的size，最后在用数组拷贝复制到一个精确大小的byte数组中
        int size = bmp.getWidth() * bmp.getHeight() / 8 + 1000;
        byte[] tmp = new byte[size];
        int k = 0;
        // 设置行距为0
        tmp[k++] = 0x1B;
        tmp[k++] = 0x33;
        tmp[k++] = 0x00;
        // 居中打印
        tmp[k++] = 0x1B;
        tmp[k++] = 0x61;
        tmp[k++] = 1;
        for (int j = 0; j < bmp.getHeight() / 24f; j++) {
            tmp[k++] = 0x1B;
            tmp[k++] = 0x2A;// 0x1B 2A 表示图片打印指令
            tmp[k++] = 33; // m=33时，选择24点密度打印
            tmp[k++] = (byte) (bmp.getWidth() % 256); // nL
            tmp[k++] = (byte) (bmp.getWidth() / 256); // nH
            for (int i = 0; i < bmp.getWidth(); i++) {
                for (int m = 0; m < 3; m++) {
                    for (int n = 0; n < 8; n++) {
                        byte b = px2Byte(i, j * 24 + m * 8 + n, bmp);
                        tmp[k] += tmp[k] + b;
                    }
                    k++;
                }
            }
            tmp[k++] = 10;// 换行
        }
        // 恢复默认行距
        tmp[k++] = 0x1B;
        tmp[k++] = 0x32;
        byte[] result = new byte[k];
        System.arraycopy(tmp, 0, result, 0, k);
        return result;
    }

    /**
     * 图片二值化，黑色是1，白色是0
     *
     * @param x   横坐标
     * @param y   纵坐标
     * @param bit 位图
     * @return
     */
    private static byte px2Byte(int x, int y, Bitmap bit) {
        if (x < bit.getWidth() && y < bit.getHeight()) {
            byte b;
            int pixel = bit.getPixel(x, y);
            int red = (pixel & 0x00ff0000) >> 16; // 取高两位
            int green = (pixel & 0x0000ff00) >> 8; // 取中两位
            int blue = pixel & 0x000000ff; // 取低两位
            int gray = RGB2Gray(red, green, blue);
            if (gray < 128) {
                b = 1;
            } else {
                b = 0;
            }
            return b;
        }
        return 0;
    }

    /**
     * 图片灰度的转化
     */
    private  static int RGB2Gray(int r, int g, int b) {
        // 灰度转化公式
        int gray = (int) (0.29900 * r + 0.58700 * g + 0.11400 * b);
        return gray;
    }


//    /**
//     * 标签打印数据
//     * @param shiWu
//     * @return
//     */
//    public static byte[] printMsg(BiaoQianBean.BiaoQianData.ShiWu shiWu) {
//        //标签打印
//        LabelCommand tsc = new LabelCommand();
//        tsc.addSize(40, 30); // 设置标签尺寸，按照实际尺寸设置
//        tsc.addGap(2); // 设置标签间隙，按照实际尺寸设置，如果为无间隙纸则设置为0
//        tsc.addDirection(LabelCommand.DIRECTION.BACKWARD, LabelCommand.MIRROR.NORMAL);// 设置打印方向
//        tsc.addReference(0, 0);// 设置原点坐标
//        tsc.addTear(LabelUtils.ENABLE.ON); // 撕纸模式开启
//
//        tsc.addCls();// 清除打印缓冲区
//        // 绘制简体中文
//        String price_one = "  ￥"+shiWu.getFood_price_one();
//        tsc.addText(20, 15, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
//                shiWu.getHaoma()+price_one);
//        tsc.addText(20, 50, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
//                shiWu.getShijian());
//        tsc.addText(20, 80, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
//                "--------------------");
//        StringBuffer buffer = new StringBuffer();
//        List<String> shuxingList = shiWu.getShuxingList();
//        for (int i = 0; i < shuxingList.size(); i++) {
//            buffer.append(shuxingList.get(i));
//        }
//        tsc.addText(20, 145, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
//                PrinterCmdUtils.getTSCData(buffer.toString()));
//        if (shuxingList.size() == 0) {
//            tsc.addText(20, 145, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
//                    PrinterCmdUtils.getTSCData(shiWu.getMingcheng()));
//        } else {
//            tsc.addText(20, 110, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
//                    PrinterCmdUtils.getTSCData(shiWu.getMingcheng()));
//        }
//        if (null != shiWu.getFood_desc()) {
//            tsc.addText(20, 180, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
//                    PrinterCmdUtils.getTSCData(shiWu.getFood_desc()));
//        }
//
//
//        // 绘制图片
//        // Bitmap b = BitmapFactory.decodeResource(getResources(), R.drawable.product_000001);
//        // tsc.addBitmap(20, 50, LabelCommand.BITMAP_MODE.OVERWRITE, b.getWidth(), b);
//
//        // 绘制二维码
//        // tsc.addQRCode(250, 80, LabelCommand.EEC.LEVEL_L, 5, LabelCommand.ROTATION.ROTATION_0, " www.gg.com.cn");
//
//        // 绘制条形码
//        // tsc.add1DBarcode(20, 250, LabelCommand.BARCODETYPE.CODE128, 100, LabelCommand.READABEL.EANBEL, LabelCommand.ROTATION.ROTATION_0, "printer");
//
//        tsc.addPrint(1, 1); // 打印标签
//        tsc.addSound(2, 100); // 打印标签后 蜂鸣器响
//
//        // tsc.addCashdrwer(LabelCommand.FOOT.F5, 255, 255);
//
//        Vector<Byte> datas = tsc.getCommand(); // 发送数据
//        byte[] bytes = LabelUtils.ByteTo_byte(datas);
//        return bytes;
//
//    }
//
//


    /**
     * 标签打印数据
     * @param shiWu
     * @return
     */
    public static byte[] printMsg(BiaoQianBean.BiaoQianData.ShiWu shiWu, Context context) {
        //标签打印
        LabelCommand tsc = new LabelCommand();
        tsc.addSize(40, 30); // 设置标签尺寸，按照实际尺寸设置
        tsc.addGap(2); // 设置标签间隙，按照实际尺寸设置，如果为无间隙纸则设置为0
        tsc.addDirection(LabelCommand.DIRECTION.BACKWARD, LabelCommand.MIRROR.NORMAL);// 设置打印方向
        tsc.addReference(0, 0);// 设置原点坐标
        tsc.addTear(LabelUtils.ENABLE.ON); // 撕纸模式开启

        tsc.addCls();// 清除打印缓冲区
        // 绘制简体中文
        String price_one = "";
        if (true){
            price_one = "  ￥"+shiWu.getFood_price_one();
        }
        tsc.addText(20, 15, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
                shiWu.getHaoma()+price_one);
        tsc.addText(20, 50, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
                shiWu.getShijian());
        tsc.addText(20, 80, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
                "--------------------");
        StringBuffer buffer = new StringBuffer();
        List<String> shuxingList = shiWu.getShuxingList();
        for (int i = 0; i < shuxingList.size(); i++) {
            buffer.append(shuxingList.get(i));
        }
        tsc.addText(20, 145, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
                PrinterCmdUtils.getTSCData(buffer.toString()));
        if (shuxingList.size() == 0) {
            tsc.addText(20, 145, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
                    PrinterCmdUtils.getTSCData(shiWu.getMingcheng()));
        } else {
            tsc.addText(20, 110, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
                    PrinterCmdUtils.getTSCData(shiWu.getMingcheng()));
        }
        if (true) {
            tsc.addText(20, 180, LabelCommand.FONTTYPE.SIMPLIFIED_CHINESE, LabelCommand.ROTATION.ROTATION_0, LabelCommand.FONTMUL.MUL_1, LabelCommand.FONTMUL.MUL_1,
                    PrinterCmdUtils.getTSCData(shiWu.getFood_desc()));
        }


        // 绘制图片
        // Bitmap b = BitmapFactory.decodeResource(getResources(), R.drawable.product_000001);
        // tsc.addBitmap(20, 50, LabelCommand.BITMAP_MODE.OVERWRITE, b.getWidth(), b);

        // 绘制二维码
        // tsc.addQRCode(250, 80, LabelCommand.EEC.LEVEL_L, 5, LabelCommand.ROTATION.ROTATION_0, " www.gg.com.cn");

        // 绘制条形码
        // tsc.add1DBarcode(20, 250, LabelCommand.BARCODETYPE.CODE128, 100, LabelCommand.READABEL.EANBEL, LabelCommand.ROTATION.ROTATION_0, "printer");

        tsc.addPrint(1, 1); // 打印标签
        tsc.addSound(2, 100); // 打印标签后 蜂鸣器响

        // tsc.addCashdrwer(LabelCommand.FOOT.F5, 255, 255);

        Vector<Byte> datas = tsc.getCommand(); // 发送数据
        byte[] bytes = LabelUtils.ByteTo_byte(datas);
        return bytes;

    }


    public static String getTSCData(String data){
        StringBuffer sb = new StringBuffer();
        char[] chars = data.toCharArray();
        int zzj = 0;//总数要小于24
        int length = chars.length;
        for (int i = 0; i < length; i++) {
            if (isZhongWen(chars[i])){
                zzj = zzj+2;
            }else {
                zzj++;
            }
            if (zzj < 22) {
                sb.append(chars[i]);
            }else if (zzj >= 22 && zzj <= 23){
                sb.append("..");
            }
        }
        return sb.toString();
    }


}
