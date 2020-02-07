import 'package:mvp_flutter_tutorial/base/BasePresenter.dart';
import 'package:mvp_flutter_tutorial/base/BaseView.dart';
import 'package:mvp_flutter_tutorial/constance/Constances.dart';
import 'package:mvp_flutter_tutorial/utils/intent.dart';

import './viewmodel.dart';

class Presenter implements BasePresenter {
  ViewModel _viewModel;
  BaseView _view;
  var data = [];
  Presenter(this.data) {}

  @override
  action(key, data) {
    switch (key) {
      case Constances.UP:
//        print("dataaaa:" + data["data"].toString());
        //xu ly tat ca cac su kien trong day!
        _viewModel.counter++;
        this._view.uiUpdate(this._viewModel);
        break;
      case 'BACK':
        IntentUtils.goBack(data);
        break;
      case 'next':
        if (_viewModel.counter < _viewModel.dataaa.length - 1) {
          _viewModel.counter++;
          _view.uiUpdate(_viewModel);
        }
        break;
      case 'swipeLeft':
        if (_viewModel.counter < _viewModel.dataaa.length - 1) {
          _viewModel.counter++;
          _view.uiUpdate(_viewModel);
        }
        break;
      case 'back':
        if (_viewModel.counter > 0) {
          _viewModel.counter--;
          _view.uiUpdate(_viewModel);
        }
        break;
      case 'swipeRight':
        if (_viewModel.counter > 0) {
          _viewModel.counter--;
          _view.uiUpdate(_viewModel);
        }
        break;
    }
  }

  @override
  init(view) {
    this._view = view;
    _viewModel = new ViewModel(this.data);
    this._view.uiUpdate(this._viewModel);
  }
}
