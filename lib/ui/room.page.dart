import 'package:flutter/material.dart';
import 'package:planning_poker/models/room.dart';
import 'package:planning_poker/models/system.dart';

class RoomPage extends StatefulWidget {
  static String createRoute(String roomId) {
    return 'rooms/$roomId';
  }

  static bool isMatchingPath(String path) {
    var uri = Uri.parse(path);
    return uri.pathSegments.length == 2 && uri.pathSegments[0] == 'rooms';
  }

  static String? parseRoomId(String path) {
    var uri = Uri.parse(path);
    return uri.pathSegments[1];
  }

  final String roomId;

  RoomPage({Key? key, required this.roomId}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  bool _loading = false;
  bool _error = false;
  Room? _room;

  @override
  Widget build(BuildContext context) {

    System.instance.getRoom(widget.roomId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Room ' + widget.roomId),
      ),
      body: Center(),
    );
  }
}
