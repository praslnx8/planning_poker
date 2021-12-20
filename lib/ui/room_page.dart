import 'dart:async';

import 'package:flutter/material.dart';
import 'package:planning_poker/models/room.dart';
import 'package:planning_poker/models/system.dart';
import 'package:planning_poker/ui/widgets/estimate_widget.dart';
import 'package:planning_poker/utils/dialog_utils.dart';

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
  dynamic _error;
  bool? _isFacilitator;
  Room? _room;
  StreamSubscription<Room>? _roomSubscription;

  void _setData(Room room, bool isFacilitator) {
    setState(() {
      _room = room;
      _isFacilitator = isFacilitator;
      _error = null;
    });
  }

  void _setError(error) {
    setState(() {
      _room = null;
      _error = error;
    });
  }

  @override
  void initState() {
    super.initState();
    System.instance.joinRoomAsPlayer(roomNo: widget.roomId);
    _roomSubscription = System.instance.listenToRoomUpdates(roomNo: widget.roomId).listen((updatedRoom) {
      System.instance
          .isUserFacilitator(room: updatedRoom)
          .then((isFacilitator) => _setData(updatedRoom, isFacilitator));
    }, onError: (error) => _setError(error));
  }

  @override
  void dispose() {
    _roomSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        DialogUtils.instance.showErrorDialog(context, _error!);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Room ' + widget.roomId),
        actions: [
          _buildInfoItem(Icons.people_alt, _getPlayerCount()),
          _buildInfoItem(Icons.check, _getTotalEstimate())
        ],
      ),
      body: Center(
        child: _getContent(),
      ),
    );
  }

  Row _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(icon), Padding(padding: EdgeInsets.only(left: 8, right: 16), child: Text(text))],
    );
  }

  String _getPlayerCount() => _room == null ? '0' : '${_room!.getTotalPlayers()}';

  String _getTotalEstimate() => _room == null ? '0' : '${_room!.getTotalEstimates()}';

  Widget _getContent() {
    if (_room != null && _isFacilitator != null) {
      if (_room!.getCurrentEstimate() != null) {
        return EstimateWidget(
            estimate: _room!.getCurrentEstimate()!,
            isFacilitator: _isFacilitator!,
            playerCount: _room!.players.length,
            startEstimate: _startEstimate,
            sendPokerValue: _sendPokerValue,
            reveal: _reveal);
      } else {
        if (_isFacilitator!) {
          return ElevatedButton(onPressed: () => {_startEstimate()}, child: Text('Start Estimate'));
        } else {
          return Text('Waiting for facilitator to start');
        }
      }
    }
    return CircularProgressIndicator();
  }

  _startEstimate() {
    _room!.startEstimate();
  }

  _reveal() {
    _room!.revealCurrentEstimate();
  }

  _sendPokerValue(int value) {
    System.instance.addPokerValueToCurrentEstimate(room: _room!, value: value);
  }
}
