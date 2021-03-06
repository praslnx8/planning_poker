import 'package:flutter/material.dart';
import 'package:planning_poker/models/system.dart';
import 'package:planning_poker/ui/landing_page.dart';
import 'package:planning_poker/ui/room_page.dart';

class AppRouter {
  static Widget route(String path) {
    if (RoomPage.isMatchingPath(path)) {
      final roomId = RoomPage.parseRoomId(path);
      return RoomPage(roomId: roomId!);
    }
    return LandingPage();
  }
}
