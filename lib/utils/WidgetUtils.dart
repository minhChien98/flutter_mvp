import 'package:flutter/material.dart';

class WidgetUtils {
  static listView(arr, item) {
    return ListView.builder(
        physics: new BouncingScrollPhysics(),
        itemCount: arr.length,
        itemBuilder: (BuildContext context, int position) {
          Divider();
          var e = arr[position];
          return item(e, position);
        });
  }

  static listVieww(arr, item) {
    return ListView.builder(
        physics: new BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: arr.length,
        itemBuilder: (BuildContext context, int position) {
          Divider();
          var e = arr[position];
          return item(e, position);
        });
  }

  static gridView(arr, item) {
    return GridView.builder(
        physics: new BouncingScrollPhysics(),
        padding: EdgeInsets.all(4.0),
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: arr.length,
        itemBuilder: (BuildContext context, int position) {
          var e = arr[position];
          return Card(
            child: item(e, position),
          );
        });
  }

  static View(arr, item) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(4.0),
      childAspectRatio: 8.0,
      children: <Widget>[],
    );
  }

  static showDg(context, title, content) async {
    showDialog(
        context: context,
        builder: (cxt) {
          return AlertDialog(
            title: Text(title),
            content: TextFormField(
              decoration: InputDecoration(labelText: 'Nhập tên bạn'),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
}
