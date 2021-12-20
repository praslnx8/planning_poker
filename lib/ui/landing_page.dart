import 'package:flutter/material.dart';
import 'package:planning_poker/models/room.dart';
import 'package:planning_poker/models/system.dart';
import 'package:planning_poker/ui/room_page.dart';
import 'package:planning_poker/utils/dialog_utils.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _loading = false;
  String? _error;
  Room? _room;

  final _formKey = GlobalKey<FormState>();
  final _roomNoFieldController = TextEditingController();

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
    System.instance
        .joinRoomAsPlayer(roomNo: roomNo)
        .then((room) => {_setRoom(room)}, onError: (error) => _setError(error));
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
      return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Distributed scrum planning poker for estimating agile projects',
                  style: Theme.of(context).textTheme.headline6),
              Padding(padding: EdgeInsets.all(12)),
              Text(
                  ' First person to create the room is the moderator. Share the url or room number with other team members to join the room.',
                  style: Theme.of(context).textTheme.subtitle1),
              Padding(padding: EdgeInsets.all(12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 240,
                    child: TextFormField(
                      controller: _roomNoFieldController,
                      maxLength: 5,
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Enter Room no';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 5.0),
                        ),
                        labelText: 'Enter Room no',
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(12)),
                  ElevatedButton(
                    onPressed: () => {
                      if (_formKey.currentState!.validate()) {_joinRoom(_roomNoFieldController.value.text)}
                    },
                    child: Text('Join Room'),
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
                onPressed: () => {_createRoom()},
                icon: Icon(Icons.add),
                label: Text('Create Room'),
              ),
            ],
          ));
    }
  }
}
