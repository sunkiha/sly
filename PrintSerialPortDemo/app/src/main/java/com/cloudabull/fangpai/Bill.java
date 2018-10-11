package com.cloudabull.fangpai;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Administrator on 2018/6/9.
 */

public class Bill implements Serializable{

    private String shop_name;//店铺名
    private String time;//下单时间
    private String order_number;//订单号-本地生成
    private String total_price;//总价格
    private String pay_type;//支付方式
    private List<Goods> goodsList;//商品列表

    public String getShop_name() {
        return shop_name;
    }

    public void setShop_name(String shop_name) {
        this.shop_name = shop_name;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getOrder_number() {
        return order_number;
    }

    public void setOrder_number(String order_number) {
        this.order_number = order_number;
    }

    public String getTotal_price() {
        return total_price;
    }

    public void setTotal_price(String total_price) {
        this.total_price = total_price;
    }

    public String getPay_type() {
        return pay_type;
    }

    public void setPay_type(String pay_type) {
        this.pay_type = pay_type;
    }

    public List<Goods> getGoodsList() {
        return goodsList;
    }

    public void setGoodsList(List<Goods> goodsList) {
        this.goodsList = goodsList;
    }

    public static class Goods{

        private String goods_price;
        private String goods_num;
        private String goods_name;

        public Goods() {
        }

        public Goods(String goods_price, String goods_num, String goods_name) {
            this.goods_price = goods_price;
            this.goods_num = goods_num;
            this.goods_name = goods_name;
        }

        public String getGoods_price() {
            return goods_price;
        }

        public void setGoods_price(String goods_price) {
            this.goods_price = goods_price;
        }

        public String getGoods_num() {
            return goods_num;
        }

        public void setGoods_num(String goods_num) {
            this.goods_num = goods_num;
        }

        public String getGoods_name() {
            return goods_name;
        }

        public void setGoods_name(String goods_name) {
            this.goods_name = goods_name;
        }
    }


}
