import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_flutter_tutorial/base/BaseView.dart';
import 'package:mvp_flutter_tutorial/screens/home/presenter.dart';
import 'package:mvp_flutter_tutorial/screens/home/viewmodel.dart';
import 'package:mvp_flutter_tutorial/utils/WidgetUtils.dart';

class View extends StatefulWidget {
  String title;

  View(this.title);

  @override
  _ViewState createState() => new _ViewState();
}

class _ViewState extends State<View> implements BaseView {
  ViewModel _viewModel;
  Presenter _presenter;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _presenter = new Presenter();
    _presenter.init(this);
  }

  Widget item1(item, position) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
//          Text(item['year'].toString()),
          Image.asset(
            item['icon'],
            height: 120,
          ),
        ],
      ),
      onTap: () {
        _presenter.action('icon', {"data": item["data1"], 'context': context});
      },
    );
  }

  itemDrawer(item, position) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width / 3 - 40,
      height: MediaQuery.of(context).size.width / 3 - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(200.0)),
//        border: Border.all(width: 4, color: Color.fromRGBO(255, 81, 47, 80)),
        color: item["status"] ? Colors.blueAccent : Colors.grey,
      ),
      child: GestureDetector(
        child: Image.asset(item['icon'], width: 100),
        onTap: () {
          item['context'] = context;
          item['index'] = position;
          this._presenter.action("CLICK_DRAWER", item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          Container(
            color: Colors.blueAccent,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    disabledColor: Colors.grey,
                    onPressed: () {
                      print('aaa');

                      _scaffoldKey.currentState.openDrawer();
                    }),
                Text(
                  'HOW TO DRAW',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 45,
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: WidgetUtils.gridView(this._viewModel.arr, this.item1),
              flex: 1,
            ),
//            AdsUtils.banner('google')
          ],
        ),
      ),
      drawer: Container(
//        height: 600.0,
//        margin: EdgeInsets.only(top: 75),
        width: MediaQuery.of(context).size.width / 3,
        padding: EdgeInsets.all(0.0),
        child: Drawer(
//          elevation: 20.0,
          child: Container(
            decoration: BoxDecoration(color: Colors.white10),
            child: WidgetUtils.listView(
                this._viewModel.dataDrawer, this.itemDrawer),
          ),
        ),
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
