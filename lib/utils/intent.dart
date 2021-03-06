import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntentUtils {
  static startActivity(context, compoment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => compoment,
      ),
    );
  }

  static startActivityNoBack(context, compoment) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => compoment,
      ),
    );
  }

  static startActivityForResult(context, compoment, callBack) async {
    Map results = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => compoment));

    if (results != null) {
      callBack(results);
    }
  }

//  static startActivityForResult(context, screen, callBack) async {
//    var result = await Navigator.push(
//        context,
//        new MaterialPageRoute(
//            builder: (BuildContext context) => screen, fullscreenDialog: true));
//    callBack(result);
//  }

  static goBack(data) {
//    Navigator.pop(context);
    Navigator.of(data['context']).pop(data['data']);
  }
}
