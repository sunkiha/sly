package com.kongqw.serialportlibrary;

import android.util.Log;

public class CommonUtil {
    private static final String TAG = CommonUtil.class.getSimpleName();
    private static final byte[] hex = "0123456789ABCDEF".getBytes();

    public CommonUtil() {
    }

    public static String bytesToHexString(byte[] bArray) {
        StringBuffer sb = new StringBuffer(bArray.length);

        for(int i = 0; i < bArray.length; ++i) {
            String sTemp = Integer.toHexString(255 & bArray[i]);
            if (sTemp.length() < 2) {
                sb.append(0);
            }

            sb.append(sTemp.toUpperCase());
        }

        return sb.toString();
    }

    public static String hexStr2Str(String hexStr) {
        String str = "0123456789ABCDEF";
        char[] hexs = hexStr.toCharArray();
        byte[] bytes = new byte[hexStr.length() / 2];

        for(int i = 0; i < bytes.length; ++i) {
            int n = str.indexOf(hexs[2 * i]) * 16;
            n += str.indexOf(hexs[2 * i + 1]);
            bytes[i] = (byte)(n & 255);
        }

        return new String(bytes);
    }

    public static byte[] hexToByteArr(String inHex) {
        int hexlen = inHex.length();
        byte[] result;
        if (isOdd(hexlen) == 1) {
            ++hexlen;
            result = new byte[hexlen / 2];
            inHex = "0" + inHex;
        } else {
            result = new byte[hexlen / 2];
        }

        int j = 0;

        for(int i = 0; i < hexlen; i += 2) {
            result[j] = hexToByte(inHex.substring(i, i + 2));
            ++j;
        }

        return result;
    }

    private static byte hexToByte(String inHex) {
        return (byte)Integer.parseInt(inHex, 16);
    }

    private static int isOdd(int num) {
        return num & 1;
    }

    public static String hexStrToBinStr(String hexString) {
        StringBuilder bin = new StringBuilder();
        hexString = hexString.trim();
        hexString = hexString.replaceFirst("0x", "");

        for(int i = 0; i < hexString.length(); ++i) {
            int iHex = Integer.parseInt("" + hexString.charAt(i), 16);
            StringBuilder binFragment = new StringBuilder(Integer.toBinaryString(iHex));
            if (binFragment.length() < 4) {
                int len = 4 - binFragment.length();

                for(int j = 0; j < len; ++j) {
                    binFragment.insert(0, "0");
                }
            }

            bin.append(binFragment);
            Log.i(TAG, "十六进制: " + hexString.charAt(i) + "\t二进制: " + binFragment + "\t拼接: " + bin);
        }

        return bin.toString();
    }
}
