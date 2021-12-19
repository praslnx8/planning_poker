import 'package:flutter/material.dart';
import 'package:planning_poker/models/room.dart';
import 'package:planning_poker/models/system.dart';
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
  bool _loading = false;
  dynamic _error;
  Room? _room;

  void _setRoom(Room room) {
    setState(() {
      _loading = false;
      _room = room;
      _error = null;
    });
  }

  void _setLoading() {
    setState(() {
      _loading = true;
      _room = null;
      _error = null;
    });
  }

  void _setError(error) {
    setState(() {
      _loading = false;
      _room = null;
      _error = error;
    });
  }

  @override
  void initState() {
    super.initState();
    _setLoading();
    System.instance.joinRoom(widget.roomId).then((room) => {_setRoom(room)}, onError: (error) => {_setError(error)});
    System.instance.listenToRoomUpdates(widget.roomId).listen((room) {
      _setRoom(room);
    });
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
          Row(
            children: [
              Icon(Icons.people_alt),
              Padding(
                  padding: EdgeInsets.only(left: 8, right: 16),
                  child: Text(_getPlayerCount()))
            ],
          ),
          Row(
            children: [
              Icon(Icons.check),
              Padding(
                  padding: EdgeInsets.only(left: 8, right: 16),
                  child: Text(_getTotalEstimate()))
            ],
          ),
        ],
      ),
      body: Center(child: _getContent()),
    );
  }

  String _getPlayerCount() => _room == null ? "0": _room!.getTotalPlayers().toString();
  String _getTotalEstimate() => _room == null ? "0": _room!.getTotalEstimates().toString();

  Widget _getContent() {
    if (_room != null) {
      return ElevatedButton(
          onPressed: () {
            _room!.startEstimate();
          },
          child: Text("Start Estimate"));
    }
    return CircularProgressIndicator();
  }
}
