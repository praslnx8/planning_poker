import 'package:flutter/material.dart';
import 'package:planning_poker/services/auth/auth_middleware.dart';
import 'package:planning_poker/ui/error_page.dart';
import 'package:planning_poker/ui/landing_page.dart';
import 'package:planning_poker/ui/room_page.dart';

class AppRouter {
  static Widget route(String path) {
    if (ErrorPage.isMatchingPath(path)) {
      return ErrorPage(error: ErrorPage.parseErrorMessage(path));
    } else {
      final Widget widget;
      if (RoomPage.isMatchingPath(path)) {
        final roomId = RoomPage.parseRoomId(path);
        widget = RoomPage(roomId: roomId!);
      } else {
        widget = LandingPage();
      }
      return AuthMiddlewarePage(redirectWidget: widget);
    }
  }
}
