import 'package:flutter/material.dart';
import 'package:planning_poker/models/room.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room ' + widget.roomId),
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
