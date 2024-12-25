import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowAlertMessage {
  static Future<void> showSimpleDialog(BuildContext context,
      {required String title,
        required String message,
        required bool isSuccess}) async {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: TextStyle(
                color: isSuccess ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500),
          ),
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(message),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
