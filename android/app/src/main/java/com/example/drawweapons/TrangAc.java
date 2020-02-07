package com.example.drawweapons;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.iybdzrfnoe.adx.service.AdsExchange;
import com.iybdzrfnoe.adx.service.SplashAdRequest;

public class TrangAc extends Activity {
    int i = 0;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        SplashAdRequest adRequest = new SplashAdRequest();
        adRequest.setAlwayShowAd(true);
      adRequest.setBannerId("ca-app-pub-3082814971751832/2544832082");
       // adRequest.setBannerId("ca-app-pub-3940256099942544/6300978111");
        adRequest.setResLogo(R.mipmap.ic_launcher);
        adRequest.setResBanner(R.mipmap.banner);
        adRequest.setPermissions(new String[]{});
        AdsExchange.loadSplashAd(this, adRequest);
    }
    @Override
    protected void onResume() {
        super.onResume();
        i++;
        if (i > 1) {
            Intent myIntent = new Intent(this, MainActivity.class);
            startActivity(myIntent);
            finish();
        }

    }
}
