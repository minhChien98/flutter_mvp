import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvp_flutter_tutorial/base/BasePresenter.dart';
import 'package:mvp_flutter_tutorial/base/BaseView.dart';
import 'package:mvp_flutter_tutorial/constance/Constances.dart';
import 'package:mvp_flutter_tutorial/screens/detail/view.dart' as prefix0;
import 'package:mvp_flutter_tutorial/screens/home/view.dart';
import 'package:mvp_flutter_tutorial/screens/home/viewmodel.dart';
import 'package:mvp_flutter_tutorial/utils/AdsUtils.dart';
import 'package:mvp_flutter_tutorial/utils/CallNative.dart';
import 'package:mvp_flutter_tutorial/utils/intent.dart';

class Presenter implements BasePresenter {
  ViewModel _viewModel;
  BaseView _view;

  Presenter() {
    this._viewModel = new ViewModel(0);
    CallNative.callFluterToNative(Constances.RATE, {"aa": "bb"}, (dataBack) {});
  }
  var key;
  var data;
  @override
  action(key, data) {
    this.key = key;
    this.data = data;
    switch (key) {
      case Constances.UP:
        _viewModel.counter++;
        this._view.uiUpdate(this._viewModel);
        break;
      case Constances.INTENT:
        var context = data["context"];
        IntentUtils.startActivityForResult(context, View("detail"), (aa) {
          print("data back:" + aa.toString());
        });
        break;

      case 'BACK':
        IntentUtils.goBack(data);
        break;
      case 'icon':
        adsUtils.showInter();
        break;
      case "CLICK_DRAWER":
        adsUtils.showInter();

        break;
    }
  }

  click() {
    switch (key) {
      case "icon":
        if (data['data'] != null) {
          IntentUtils.startActivityForResult(
              data["context"], prefix0.View(data["data"]), (data));
        }

        break;
      case "CLICK_DRAWER":
        tempData.sublist(data['from'], data['to']);
        this._viewModel.arr = tempData.sublist(data['from'], data['to']);
        for (int i = 0; i < this._viewModel.dataDrawer.length; i++) {
          this._viewModel.dataDrawer[i]["status"] = false;
        }
        this._viewModel.dataDrawer[data['index']]["status"] = true;
        this._view.uiUpdate(this._viewModel);
        Navigator.of(data['context']).pop();
        break;
    }
  }

  var tempData = [];
  AdsUtils adsUtils;
  @override
  init(view) {
    this._view = view;
    adsUtils = new AdsUtils();
    adsUtils.addInterstitialAd(() {
      this.click();
    });
    CallNative.callFluterToNative(
        Constances.GET_DATA_IN_ASSETS, {"data": "tesst"}, (callBack) {
      if (callBack != null) {
        tempData = jsonDecode(callBack.toString());
        this._viewModel.arr = tempData;

        this._viewModel.arr.sublist(0, 20);

        this._view.uiUpdate(this._viewModel);
      }
    });

    this._view.uiUpdate(this._viewModel);
  }
}
