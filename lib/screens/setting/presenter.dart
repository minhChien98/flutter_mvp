import 'package:mvp_flutter_tutorial/base/BasePresenter.dart';
import 'package:mvp_flutter_tutorial/base/BaseView.dart';
import 'package:mvp_flutter_tutorial/constance/Constances.dart';
import 'package:mvp_flutter_tutorial/screens/home/viewmodel.dart';
import 'package:mvp_flutter_tutorial/utils/intent.dart';

import './view.dart';

class Presenter implements BasePresenter {
  ViewModel _viewModel;
  BaseView _view;

  Presenter() {
    this._viewModel = new ViewModel(0);
  }

  @override
  action(key, data) {
    switch (key) {
      case Constances.UP:
//        print("dataaaa:" + data["data"].toString());
        //xu ly tat ca cac su kien trong day!
        _viewModel.counter++;
        this._view.uiUpdate(this._viewModel);
        break;
      case Constances.INTENT:
        var context = data["context"];
        IntentUtils.startActivityForResult(context, View("detail"), (data) {
          print("data back:" + data.toString());
        });
        break;
      case 'BACK':
        IntentUtils.goBack(data);
        break;
    }
  }

  @override
  init(view) {
    this._view = view;
    this._view.uiUpdate(this._viewModel);
  }
}
