import 'package:planning_poker/adapters/room_adapter.dart';
import 'package:planning_poker/adapters/user_adapter.dart';
import 'package:planning_poker/models/facilitator.dart';
import 'package:planning_poker/models/room.dart';
import 'package:planning_poker/models/user.dart';

typedef RoomCreatedCallback = void Function(Room room);
typedef RoomCreateFailedCallback = void Function(String error);
typedef RoomCreateProcessingCallback = void Function();

typedef RoomJoinedCallback = void Function(Room room);
typedef RoomJoinFailedCallback = void Function(String error);
typedef RoomJoinProcessingCallback = void Function();

class System {
  static System _instance = System._();

  static System get instance => _instance;

  System._();

  User? _user;

  void login() {
    UserAdapter.instance.login().then((uid) => {_user = User(uid)});
  }

  void joinRoom(String roomNo,
      {required RoomJoinProcessingCallback onProcessing,
      required RoomJoinedCallback onRoomJoined,
      required RoomJoinFailedCallback onRoomJoinFailed}) {}

  void createRoom(
      {required RoomCreateProcessingCallback onProcessing,
      required RoomCreatedCallback onRoomCreated,
      required RoomCreateFailedCallback onRoomCreateFailed}) async {
    onProcessing();

    if (_user != null) {
      RoomAdapter.instance.getRoomId().then((roomId) async {
        final Facilitator facilitator = Facilitator(_user!.id);
        final Room room = Room.init(roomId, facilitator);
        await RoomAdapter.instance.createRoom(room);
        onRoomCreated(room);
      }).onError((error, stackTrace) {
        onRoomCreateFailed('error');
      });
    } else {
      onRoomCreateFailed('Login failed');
    }
  }
}
