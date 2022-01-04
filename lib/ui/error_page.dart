import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  static String createRoute({String? errorMessage}) {
    if (errorMessage != null) {
      return 'error?msg=$errorMessage';
    } else {
      return 'error';
    }
  }

  static bool isMatchingPath(String path) {
    var uri = Uri.parse(path);
    return uri.pathSegments.length == 1 && uri.pathSegments[0] == 'error';
  }

  static String? parseErrorMessage(String path) {
    var uri = Uri.parse(path);
    return uri.queryParameters['msg'];
  }

  final String? error;

  ErrorPage({this.error});

  @override
  _ErrorPageState createState() {
    return _ErrorPageState();
  }
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: widget.error != null ? Text(widget.error!) : Text('Error')));
  }
}
