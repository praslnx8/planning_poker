import 'package:flutter/material.dart';

class DialogUtils {
  static DialogUtils _instance = DialogUtils._();

  static DialogUtils get instance => _instance;

  DialogUtils._();

  Future<void> showErrorDialog(BuildContext context, String errorMessage) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
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
