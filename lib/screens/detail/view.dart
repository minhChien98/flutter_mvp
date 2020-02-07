import 'package:flutter/material.dart';
import 'package:mvp_flutter_tutorial/base/BaseView.dart';
import 'package:photo_view/photo_view.dart';
import 'package:swipedetector/swipedetector.dart';

import './presenter.dart';
import './viewmodel.dart';

class View extends StatefulWidget {
  var data;

  View(this.data) {
    print("data in view detai:" + this.data.toString());
  }

  @override
  _ViewState createState() => new _ViewState();
}

class _ViewState extends State<View>
    with SingleTickerProviderStateMixin
    implements BaseView {
  ViewModel _viewModel;
  Presenter _presenter;
  dynamic temp;

  @override
  void initState() {
    super.initState();
    print(widget.data.length);
    _presenter = new Presenter(this.widget.data);
    _presenter.init(this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
//        title: new Text('detail'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color.fromRGBO(242, 56, 255, 100),
                    ),
                    onPressed: () {
                      _presenter
                          .action('BACK', {"context": context, "data": null});
                    }),
                Text(
                  _viewModel.counter.toString() +
                      '/ ' +
                      (widget.data.length - 1).toString(),
                  style: TextStyle(color: Color.fromRGBO(242, 56, 255, 100)),
                ),
                Container(
                  width: 45,
                )
              ],
            ),
          )
        ],
      ),
      body: Center(
//        color: Colors.green,
        child: SwipeDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromRGBO(242, 56, 255, 100),
                  ),
                  onPressed: () {
                    _presenter.action("back", {'data': "hihi"});
                  }),
              Expanded(
                flex: 1,
                child: Container(
//                    color: Colors.brown,
                    width: double.infinity,
                    height: double.infinity,
                    child: PhotoView(
                      imageProvider:
                          AssetImage(this.widget.data[_viewModel.counter]),
                      backgroundDecoration:
                          BoxDecoration(color: Theme.of(context).canvasColor),
                    )),
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromRGBO(242, 56, 255, 100),
                  ),
                  onPressed: () {
                    _presenter.action("next", {'data': "hihi"});
                  })
            ],
          ),
          onSwipeLeft: () {
            _presenter.action("swipeLeft", {'data': "hihi"});
          },
          onSwipeRight: () {
            _presenter.action("swipeRight", {'data': "hihi"});
          },
          swipeConfiguration: SwipeConfiguration(
              verticalSwipeMinVelocity: 50.0,
              verticalSwipeMinDisplacement: 25.0,
              verticalSwipeMaxWidthThreshold: 100.0,
              horizontalSwipeMaxHeightThreshold: 50.0,
              horizontalSwipeMinDisplacement: 25.0,
              horizontalSwipeMinVelocity: 50.0),
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

//child: SwipeDetector(
//child: Container(
//child: Row(
//children: <Widget>[
//IconButton(
//icon: Icon(
//Icons.arrow_back_ios,
//color: Color.fromRGBO(242, 56, 255, 100),
//),
//onPressed: () {
//_presenter.action("back", {'data': "hihi"});
//}),
//Container(
//width: 250,
//height: 100,
//child: PhotoView(
//imageProvider: AssetImage(
//this.widget.data[_viewModel.counter]),
//backgroundDecoration: BoxDecoration(
//color: Theme.of(context).canvasColor),
//)),
//IconButton(
//icon: Icon(
//Icons.arrow_forward_ios,
//color: Color.fromRGBO(242, 56, 255, 100),
//),
//onPressed: () {
//_presenter.action("next", {'data': "hihi"});
//})
//],
//),
//),
//onSwipeLeft: () {
//_presenter.action("swipeLeft", {'data': "hihi"});
//},
//onSwipeRight: () {
//_presenter.action("swipeRight", {'data': "hihi"});
//},
//swipeConfiguration: SwipeConfiguration(
//verticalSwipeMinVelocity: 50.0,
//verticalSwipeMinDisplacement: 25.0,
//verticalSwipeMaxWidthThreshold: 100.0,
//horizontalSwipeMaxHeightThreshold: 50.0,
//horizontalSwipeMinDisplacement: 25.0,
//horizontalSwipeMinVelocity: 50.0),
//),
