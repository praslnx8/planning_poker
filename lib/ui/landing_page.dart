import 'package:flutter/material.dart';
import 'package:planning_poker/models/room.dart';
import 'package:planning_poker/models/system.dart';
import 'package:planning_poker/ui/room_page.dart';
import 'package:planning_poker/ui/widgets/join_room_widget.dart';
import 'package:planning_poker/utils/app_context_extension.dart';
import 'package:planning_poker/utils/dialog_utils.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  static bool isMatchingPath(String path) {
    var uri = Uri.parse(path);
    return uri.pathSegments.length == 0;
  }

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _loading = false;
  String? _error;
  Room? _room;

  void _setLoading() {
    setState(() {
      _loading = true;
      _error = null;
      _room = null;
    });
  }

  void _setError(String error) {
    setState(() {
      _loading = false;
      _error = error;
      _room = null;
    });
  }

  void _setRoom(Room room) {
    setState(() {
      _loading = false;
      _error = null;
      _room = room;
    });
  }

  void _createRoom() {
    _setLoading();
    System.instance.createRoom().then((room) => _setRoom(room), onError: (error) => _setError('$error'));
  }

  void _joinRoom(String roomNo) {
    _setLoading();
    System.instance.getRoom(roomNo: roomNo).then((room) => {_setRoom(room)}, onError: (error) => _setError(error));
  }

  @override
  Widget build(BuildContext context) {
    if (_room != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(RoomPage.createRoute(_room!.id));
      });
    }
    if (_error != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        DialogUtils.instance.showErrorDialog(context, _error!);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Planning Poker'),
      ),
      body: Center(
        child: _getContent(),
      ),
    );
  }

  Widget _getContent() {
    if (_loading) {
      return CircularProgressIndicator();
    } else {
      return Center(
          child: SizedBox(
              width: 720,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(context.resources.strings.aboutPlanningPoker, style: Theme.of(context).textTheme.headline6),
                    Padding(padding: EdgeInsets.all(12)),
                    Text(context.resources.strings.roomCreateInstruction, style: Theme.of(context).textTheme.subtitle1),
                    Padding(padding: EdgeInsets.all(24)),
                    JoinRoomWidget(joinRoom: _joinRoom),
                    Padding(padding: EdgeInsets.all(8)),
                    Text(
                      context.resources.strings.or,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Padding(padding: EdgeInsets.all(8)),
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20))),
                      onPressed: () => {_createRoom()},
                      child: Text(context.resources.strings.createNewRoom),
                    )
                  ])));
    }
  }
}
