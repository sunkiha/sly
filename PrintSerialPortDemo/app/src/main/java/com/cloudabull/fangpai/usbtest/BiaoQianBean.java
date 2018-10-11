package com.cloudabull.fangpai.usbtest;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Administrator on 2017/5/31.
 */

public class BiaoQianBean implements Serializable {

    private List<BiaoQianData> biaoQianList;

    public List<BiaoQianData> getBiaoQianList() {
        return biaoQianList;
    }

    public void setBiaoQianList(List<BiaoQianData> biaoQianList) {
        this.biaoQianList = biaoQianList;
    }

    public static class BiaoQianData implements Serializable {
        private String ip;
        private List<ShiWu> shiWuList;

//        private String haoma;//取餐号或者餐牌号
//        private String shijian;//时间
//        private ShiWu shiWu;//菜品


        public List<ShiWu> getShiWuList() {
            return shiWuList;
        }

        public void setShiWuList(List<ShiWu> shiWuList) {
            this.shiWuList = shiWuList;
        }

        public String getIp() {
            return ip;
        }

        public void setIp(String ip) {
            this.ip = ip;
        }

//        public String getHaoma() {
//            return haoma;
//        }
//
//        public void setHaoma(String haoma) {
//            this.haoma = haoma;
//        }
//
//        public String getShijian() {
//            return shijian;
//        }
//
//        public void setShijian(String shijian) {
//            this.shijian = shijian;
//        }
//
//        public ShiWu getShiWu() {
//            return shiWu;
//        }
//
//        public void setShiWu(ShiWu shiWu) {
//            this.shiWu = shiWu;
//        }

        public static class ShiWu implements Serializable {
            private String ip;
            private String haoma;//取餐号或者餐牌号
            private String shijian;//时间
            private String mingcheng;//名称
            private List<String> shuxingList;//属性
            private String food_desc = "";//菜品介绍
            private String food_price_one;//菜品价格

            public String getFood_price_one() {
                return food_price_one;
            }

            public void setFood_price_one(String food_price_one) {
                this.food_price_one = food_price_one;
            }

            public String getFood_desc() {
                return food_desc;
            }

            public void setFood_desc(String food_desc) {
                this.food_desc = food_desc;
            }

            public String getIp() {
                return ip;
            }

            public void setIp(String ip) {
                this.ip = ip;
            }

            public String getHaoma() {
                return haoma;
            }

            public void setHaoma(String haoma) {
                this.haoma = haoma;
            }

            public String getShijian() {
                return shijian;
            }

            public void setShijian(String shijian) {
                this.shijian = shijian;
            }

            public String getMingcheng() {
                return mingcheng;
            }

            public void setMingcheng(String mingcheng) {
                this.mingcheng = mingcheng;
            }

            public List<String> getShuxingList() {
                return shuxingList;
            }

            public void setShuxingList(List<String> shuxingList) {
                this.shuxingList = shuxingList;
            }
        }
    }
}
