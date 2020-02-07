package com.example.drawweapons;

import android.os.Bundle;


import com.crashlytics.android.Crashlytics;
import com.example.drawweapons.utils.CallNative;

import io.fabric.sdk.android.Fabric;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {

    CallNative callNative;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        callNative = new CallNative();
        Fabric.with(this, new Crashlytics());
        callNative.callFlutterNative(this);
        callNative.callNativeFlutter(this);


    }


}
