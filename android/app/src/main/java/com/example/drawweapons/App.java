package com.example.drawweapons;

import android.content.Context;

import com.crashlytics.android.Crashlytics;
import com.iybdzrfnoe.adx.service.AdsExchange;

import io.fabric.sdk.android.Fabric;
import io.flutter.app.FlutterApplication;

public class App extends FlutterApplication {
    static Context context;

    public static Context getContext() {
        return context;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        Fabric.with(this, new Crashlytics());

       AdsExchange.init(this, "5e377edd79dff95524083265");
        this.context = this;
    }
}
