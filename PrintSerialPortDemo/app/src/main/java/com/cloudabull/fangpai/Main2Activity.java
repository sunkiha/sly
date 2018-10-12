package com.cloudabull.fangpai;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.InputDevice;
import android.view.KeyEvent;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class Main2Activity extends AppCompatActivity {
    EditText et;
    EditText et2;
    EditText et3;
    String devive="Linux 3.4.35 with dwc_otg_pcd HID Gadget";
    private boolean mCaps = true;
    private StringBuffer scannerResult;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);
        scannerResult = new StringBuffer();
        et = findViewById(R.id.et);
        et2 = findViewById(R.id.et2);
        et3 = findViewById(R.id.et3);
   /*     et.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (keyEvent.getKeyCode() == KeyEvent.KEYCODE_ENTER) {
                    Log.d("xxxxxxx", et.getText().toString());
                    int[] did = InputDevice.getDeviceIds();
                    StringBuffer sb = new StringBuffer();
                    for (int id : did) {
                        sb.append(InputDevice.getDevice(id).getName());
                    }
                    et2.setText(sb.toString());
                    Toast.makeText(textView.getContext(), et.getText().toString(), Toast.LENGTH_LONG).show();
                }
                return false;
            }
        });*/

    }

    @Override
    public boolean dispatchKeyEvent(KeyEvent event) {
        analysisKeyEvent(event);
       /* if (event.getAction() == KeyEvent.ACTION_DOWN && event.getRepeatCount() == 0) {
            int keyCode = event.getKeyCode();
            if (keyCode >= KeyEvent.KEYCODE_0 && keyCode <= KeyEvent.KEYCODE_9) {
                scannerResult.append(keyCode - KeyEvent.KEYCODE_0);
                return true;
            }
            if (keyCode == KeyEvent.KEYCODE_ENTER) {
                scannerResult.toString();
                et3.setText(scannerResult.toString());
                Toast.makeText(et.getContext(), scannerResult.toString(), Toast.LENGTH_LONG).show();
                scannerResult = new StringBuilder();
                int[] did = InputDevice.getDeviceIds();
                StringBuffer sb = new StringBuffer();
                for (int id : did) {
                    sb.append(InputDevice.getDevice(id).getName()+"    ");
                }
                String name=event.getDevice().getName();
                et2.setText(name+":"+sb.toString());

                return true;
            }
        }*/

        return super.dispatchKeyEvent(event);
    }


    //获取扫描内容
    private char getInputCode(KeyEvent event) {

        int keyCode = event.getKeyCode();

        char aChar;

        if (keyCode >= KeyEvent.KEYCODE_A && keyCode <= KeyEvent.KEYCODE_Z) {
            //字母
            aChar = (char) ((mCaps ? 'A' : 'a') + keyCode - KeyEvent.KEYCODE_A);
        } else if (keyCode >= KeyEvent.KEYCODE_0 && keyCode <= KeyEvent.KEYCODE_9) {
            //数字
            aChar = (char) ('0' + keyCode - KeyEvent.KEYCODE_0);
        } else {
            //其他符号
            switch (keyCode) {
                case KeyEvent.KEYCODE_PERIOD:
                    aChar = '.';
                    break;
                case KeyEvent.KEYCODE_MINUS:
                    aChar = mCaps ? '_' : '-';
                    break;
                case KeyEvent.KEYCODE_SLASH:
                    aChar = '/';
                    break;
                case KeyEvent.KEYCODE_BACKSLASH:
                    aChar = mCaps ? '|' : '\\';
                    break;
                default:
                    aChar = 0;
                    break;
            }
        }

        return aChar;

    }
    /**
     * shift键检查
     * @param event
     */
    private void checkLetterStatus(KeyEvent event) {
        int keyCode = event.getKeyCode();
        if (keyCode == KeyEvent.KEYCODE_SHIFT_RIGHT || keyCode == KeyEvent.KEYCODE_SHIFT_LEFT) {
            if (event.getAction() == KeyEvent.ACTION_DOWN) {
                //按着shift键，表示大写
                mCaps = true;
            } else {
                //松开shift键，表示小写
                mCaps = false;
            }
        }
    }

    /**
     * 扫码设备事件解析
     * @param event
     */
    public void analysisKeyEvent(KeyEvent event) {

        int keyCode = event.getKeyCode();


        //字母大小写判断
       // checkLetterStatus(event);

        if (event.getAction() == KeyEvent.ACTION_DOWN) {

            char aChar = getInputCode(event);

            if (aChar != 0) {
                scannerResult.append(aChar);
            }

            if (keyCode == KeyEvent.KEYCODE_ENTER&&devive.equals(event.getDevice().getName())) {
                //若为回车键，直接返回
                et3.setText(scannerResult.toString());
                Toast.makeText(et.getContext(), scannerResult.toString(), Toast.LENGTH_LONG).show();
                scannerResult = new StringBuffer();
                int[] did = InputDevice.getDeviceIds();
                StringBuffer sb = new StringBuffer();
                for (int id : did) {
                    sb.append(InputDevice.getDevice(id).getName()+"    ");
                }
                String name=event.getDevice().getName();
                et2.setText(name+":"+sb.toString());
            } else {

            }

        }
    }
}
