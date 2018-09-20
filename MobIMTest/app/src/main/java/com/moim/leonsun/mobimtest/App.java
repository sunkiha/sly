package com.moim.leonsun.mobimtest;

import android.app.Application;

import com.mob.MobApplication;
import com.mob.MobSDK;

public class App extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
       MobSDK.init(this);
    }
}
