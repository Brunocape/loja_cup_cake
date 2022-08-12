import 'package:flutter/material.dart';

class LoadAndToast{

  showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    return  scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  showLoaderDialog(BuildContext context, String txt) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Expanded(child:Container(margin: EdgeInsets.only(left: 7), child:  Text(txt))),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}