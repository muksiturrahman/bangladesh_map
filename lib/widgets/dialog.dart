import 'package:flutter/material.dart';

class ReUsableDialog {
  static Future<void> show(BuildContext context, String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('OnPress Dialog'),
          content: Text('Hi, I am $message'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
