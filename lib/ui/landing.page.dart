import 'package:flutter/material.dart';
import 'package:planning_poker/models/system.dart';

class LandingPage extends StatefulWidget {
  final System system;

  LandingPage({Key? key, required this.system}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  void _joinRoom(String roomNo) {
    setState(() {
      widget.system
          .joinRoom(roomNo, onProcessing: () => {}, onRoomJoined: (room) => {}, onRoomJoinFailed: (error) => {});
    });
  }

  void _createRoom() {
    setState(() {
      widget.system.createRoom(onProcessing: () => {}, onRoomCreated: (room) => {}, onRoomCreateFailed: (error) => {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
                // Respond to button press
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
