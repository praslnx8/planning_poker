import 'package:flutter/material.dart';
import 'package:planning_poker/models/room.dart';
import 'package:planning_poker/models/system.dart';
import 'package:planning_poker/ui/room.page.dart';

class LandingPage extends StatefulWidget {
  final System system;

  LandingPage({Key? key, required this.system}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _loading = false;
  bool _error = false;
  Room? _room;

  void _joinRoom(String roomNo) {
    widget.system.joinRoom(roomNo,
        onProcessing: () => {_setLoading()},
        onRoomJoined: (room) => {_setRoom(room)},
        onRoomJoinFailed: (error) => {_setError()});
  }

  void _setLoading() {
    setState(() {
      _loading = true;
      _error = false;
      _room = null;
    });
  }

  void _setError() {
    setState(() {
      _loading = false;
      _error = true;
      _room = null;
    });
  }

  void _setRoom(Room room) {
    setState(() {
      _loading = false;
      _error = false;
      _room = room;
    });
  }

  void _createRoom() {
    widget.system.createRoom(
        onProcessing: () => {_setLoading()},
        onRoomCreated: (room) => {_setRoom(room)},
        onRoomCreateFailed: (error) => {_setError()});  }

  @override
  Widget build(BuildContext context) {
    if (_room != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(RoomPage.createRoute(_room!.getRoomId()));
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Planning Poker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 240,
                  child: TextFormField(
                    initialValue: '',
                    maxLength: 5,
                    decoration: InputDecoration(
                      icon: Icon(Icons.meeting_room),
                      labelText: 'Enter Room no',
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(12)),
                ElevatedButton(
                  onPressed: () => {},
                  child: Text('Join'),
                )
              ],
            ),
            Padding(padding: EdgeInsets.all(12)),
            Text(
              'or',
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(padding: EdgeInsets.all(12)),
            OutlinedButton.icon(
              onPressed: () {
                _createRoom();
              },
              icon: Icon(Icons.add),
              label: Text("Create Room"),
            ),
          ],
        ),
      ),
    );
  }
}
