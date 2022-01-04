import 'package:flutter/material.dart';
import 'package:planning_poker/models/system.dart';
import 'package:planning_poker/ui/error_page.dart';

class AuthMiddlewarePage extends StatelessWidget {
  final Widget redirectWidget;

  AuthMiddlewarePage({required this.redirectWidget});

  @override
  Widget build(BuildContext context) {
    System.instance.getUser().then(
        (user) => {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => redirectWidget))},
        onError: (error) => Navigator.of(context).pushNamed(ErrorPage.createRoute(errorMessage: error?.toString())));
    return Scaffold(body: CircularProgressIndicator());
  }
}
