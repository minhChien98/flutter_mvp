import 'package:flutter/material.dart';
import 'package:mvp_flutter_tutorial/base/BasePresenter.dart';
import 'package:mvp_flutter_tutorial/base/BaseView.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'Presenter.dart';
import 'ViewModel.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SplashScreen>
    with AutomaticKeepAliveClientMixin<SplashScreen>
    implements BaseView {
  BasePresenter _presenter;
  ViewModel _viewModel;

  @override
  void initState() {
    _presenter = new Presenter(context);
    _presenter.init(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image(
          image: new AssetImage("lib/assets/images/splash.png"),
          width: width,
          height: height,
        ),
        Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Text(
              _viewModel.i.toString() + "%",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment(0, 0),
              child: LinearPercentIndicator(
                lineHeight: 12.0,
                percent: this._viewModel.i / 100,
                progressColor: Colors.black,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Loadding ....",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ],
    ));
  }

  @override
  uiUpdate(viewModel) {
    setState(() {
      this._viewModel = viewModel;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
