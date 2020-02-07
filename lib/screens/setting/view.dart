import 'package:flutter/material.dart';
import 'package:mvp_flutter_tutorial/base/BaseView.dart';
import 'package:mvp_flutter_tutorial/constance/Constances.dart';
import 'package:mvp_flutter_tutorial/screens/home/presenter.dart';
import 'package:mvp_flutter_tutorial/screens/home/viewmodel.dart';

class View extends StatefulWidget {
  String title;

  View(this.title);

  @override
  _ViewState createState() => new _ViewState();
}

class _ViewState extends State<View> implements BaseView {
  ViewModel _viewModel;
  Presenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = new Presenter();
    _presenter.init(this);

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: Image.asset("android/app/src/main/assets/1/0.png"),
//        child: Center(
//          child: IconButton(
//              icon: Icon(Icons.add_circle),
//              onPressed: () {
//                _presenter.action(Constances.INTENT,
//                    {"data": "asdaksjdhajks", "context": context});
//              }),
//        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () =>
//        this._presenter.action(key, data)
            this._presenter.action(Constances.UP, {"data": "Thanh"}),
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }

  @override
  uiUpdate(viewModel) {
    setState(() {
      this._viewModel = viewModel;
    });
  }
}
