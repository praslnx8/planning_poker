import 'package:flutter/material.dart';

class RedirectPage extends StatefulWidget {
  final String redirectUrl;

  RedirectPage({required this.redirectUrl});

  @override
  _RedirectPageState createState() {
    return _RedirectPageState();
  }
}

class _RedirectPageState extends State<RedirectPage> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed(widget.redirectUrl);
    });
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
