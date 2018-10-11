package com.cloudabull.fangpai;

import android.app.Application;
import android.content.Context;
import android.os.Build;

import java.lang.reflect.Field;

public class App extends Application {
    public static Context bc;

    @Override
    public void onCreate() {
        super.onCreate();
        bc = getApplicationContext();
   /*     try {
            Field field = Build.class.getDeclaredField("BRAND");
            field.setAccessible(true);
            field.set(Build.class.newInstance(), "FounPad");
        } catch (Exception e) {
            e.printStackTrace();
        }*/
    }
}
