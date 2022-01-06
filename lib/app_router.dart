import 'package:flutter/material.dart';
import 'package:planning_poker/models/system.dart';
import 'package:planning_poker/ui/error_page.dart';
import 'package:planning_poker/ui/landing_page.dart';
import 'package:planning_poker/ui/login_page.dart';
import 'package:planning_poker/ui/redirect_page.dart';
import 'package:planning_poker/ui/room_page.dart';
import 'package:planning_poker/utils/console_log.dart';

class AppRouter {
  static Widget route(String path) {
    ConsoleLog.i(path);

    if (!System.instance.isLoggedIn()) {
      if (ErrorPage.isMatchingPath(path)) {
        return ErrorPage(error: ErrorPage.parseErrorMessage(path));
      } else if (LoginPage.isMatchingPath(path)) {
        return LoginPage(redirectPath: LoginPage.parseRedirectUrl(path));
      } else {
        return RedirectPage(redirectUrl: LoginPage.createRoute(path));
      }
    }

    if (ErrorPage.isMatchingPath(path)) {
      return ErrorPage(error: ErrorPage.parseErrorMessage(path));
    } else if (RoomPage.isMatchingPath(path)) {
      final roomId = RoomPage.parseRoomId(path);
      return RoomPage(roomId: roomId!);
    } else if (LandingPage.isMatchingPath(path)) {
      return LandingPage();
    } else if (LoginPage.isMatchingPath(path)) {
      return LoginPage(redirectPath: LoginPage.parseRedirectUrl(path));
    } else {
      return ErrorPage();
    }
  }
}
