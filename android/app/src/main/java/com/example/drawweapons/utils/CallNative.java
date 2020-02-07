package com.example.drawweapons.utils;

import android.content.Context;
import android.content.res.AssetManager;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.example.drawweapons.utils.sharedpref.SharedPrefsUtils;
import com.example.ratedialog.RatingDialog;

import java.io.IOException;
import java.util.Timer;
import java.util.TimerTask;


import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class CallNative implements EventChannel.StreamHandler ,RatingDialog.RatingDialogInterFace{
    private static final String CHANNEL = "CALL_FLUTTER_NATIVE";

    public static final String CALL_NATIVE_FLUTTER = "CALL_NATIVE_FLUTTER";
    private String TAG = CallNative.class.getSimpleName();
    Context context;


    public void showRateDialog() {
        int count = SharedPrefsUtils.getInstance(context).getInt("rate");

        if (count < 2) {
            RatingDialog ratingDialog = new RatingDialog(context);
            ratingDialog.setRatingDialogListener(this);
            ratingDialog.showDialog();
        }


    }

    public void callFlutterNative(FlutterActivity context) {
        this.context = context;

        new MethodChannel(context.getFlutterView(), CHANNEL).setMethodCallHandler(
                (call, result) -> {
                    Log.e(TAG, call.method + "---" + call.arguments.toString());
                    if(call.method.equals("RATE")){
                        showRateDialog();
                    }
                    if (call.method.equals("GET_DATA_IN_ASSETS")) {
//                        List<String> listFileName = new ArrayList<>();
                        AssetManager aMan = context.getAssets();
                        JSONArray jsonArray = new JSONArray();

                        try {
                            for (int indexFolder = 1; indexFolder <= 100; indexFolder++) {
                                JSONObject jsonObject = new JSONObject();
                                JSONArray tempArray = new JSONArray();
                                jsonObject.put("name", indexFolder);
                                jsonObject.put("year", indexFolder);


                                String[] filelist = aMan.list(indexFolder + "");
                                jsonObject.put("icon", "android/app/src/main/assets/"+indexFolder+"/"+filelist[0]);
                                for (int i = 1; i < filelist.length; i++) {
                                    tempArray.put("android/app/src/main/assets/"+indexFolder+"/"+filelist[i]);
                                }
                                jsonObject.put("data1", tempArray);
                                jsonArray.put(jsonObject);
                            }


                        } catch (IOException e) {
                            e.printStackTrace();
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                        Log.d("dataa", "callFlutterNative: " + jsonArray.toString());
                        result.success(jsonArray.toString());
                    }


                });

    }


    int i;

    Timer myTimer;
    TimerTask doThis;
    Handler handler = new Handler(Looper.getMainLooper());

    public void callNativeFlutter(FlutterActivity context) {
        i = 0;
        new EventChannel(context.getFlutterView(), CALL_NATIVE_FLUTTER).setStreamHandler(this);
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {


        myTimer = new Timer();
        int delay = 0;   // delay for 30 sec.
        int period = 1000;  // repeat every 60 sec.
        doThis = new TimerTask() {
            public void run() {

                i++;
                handler.post(() -> {
                    eventSink.success(i + "");
                });


            }
        };

        myTimer.scheduleAtFixedRate(doThis, delay, period);

    }

    @Override
    public void onCancel(Object o) {
        myTimer.cancel();

    }

    @Override
    public void onDismiss() {

    }

    @Override
    public void onSubmit(float rating) {
        int count = SharedPrefsUtils.getInstance(context).getInt("rate");
        count++;
        SharedPrefsUtils.getInstance().putInt("rate", count);
        UtilsMenu.rateApp(context);
    }

    @Override
    public void onRatingChanged(float rating) {

    }
}
