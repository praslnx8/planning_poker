import 'package:flutter/material.dart';
import 'package:planning_poker/models/system.dart';
import 'package:planning_poker/models/user.dart';
import 'package:planning_poker/ui/error_page.dart';

class LoginPage extends StatefulWidget {
  static String createRoute(String redirectUrl) {
    return 'login?redirectUrl=$redirectUrl';
  }

  static bool isMatchingPath(String path) {
    var uri = Uri.parse(path);
    return uri.pathSegments.length == 1 && uri.pathSegments[0] == 'login';
  }

  static String? parseRedirectUrl(String path) {
    var uri = Uri.parse(path);
    return uri.queryParameters['redirectUrl'];
  }

  final String? redirectPath;

  LoginPage({required this.redirectPath});

  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  User? user;
  dynamic error;

  void _setUser(User user) {
    setState(() {
      this.user = user;
    });
  }

  void _setError(dynamic error) {
    setState(() {
      this.error = error;
    });
  }

  @override
  void initState() {
    super.initState();
    System.instance.getUser().then((user) => {_setUser(user)}, onError: (error) => _setError(error));
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(widget.redirectPath != null ? widget.redirectPath! : '/');
      });
    } else if (error != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(ErrorPage.createRoute(errorMessage: error?.toString()));
      });
    }
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
