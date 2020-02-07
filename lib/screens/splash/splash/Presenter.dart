import 'dart:async';

import 'package:mvp_flutter_tutorial/base/BasePresenter.dart';
import 'package:mvp_flutter_tutorial/base/BaseView.dart';
import 'package:mvp_flutter_tutorial/screens/home/View.dart';
import 'package:mvp_flutter_tutorial/utils/AdsUtils.dart';
import 'package:mvp_flutter_tutorial/utils/intent.dart';

import 'ViewModel.dart';

class Presenter implements BasePresenter {
  BaseView _view;
  ViewModel _viewModel;
  var context;

  Presenter(context) {
    this.context = context;
  }

  @override
  void action(key, data) {}
  AdsUtils adsUtils;
  @override
  void init(view) {
    _viewModel = new ViewModel([
      {"name": ""}
    ]);

    _view = view;
    _view.uiUpdate(_viewModel);
    adsUtils = new AdsUtils();
    adsUtils.addInterstitialAd(() {
      IntentUtils.startActivityNoBack(context, View("afad"));
    });

    Timer.periodic(new Duration(milliseconds: 10), (timer) {
      if (_viewModel.i < 99) {
        _viewModel.i++;
        _view.uiUpdate(_viewModel);
      } else {
        timer.cancel();
        adsUtils.showInter();
      }
    });
  }
}
