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

  Future<Room> joinRoom(String roomNo) async {
    final room = await RoomAdapter.instance.getRoom(roomNo);

    if (_user != null) {
      await room.joinRoom(_user!);
      return Future.value(room);
    } else {
      return Future.error('User not available');
    }
  }

  Future<Room> createRoom() async {
    if (_user != null) {
      final roomId = await RoomAdapter.instance.getRoomId();
      final Facilitator facilitator = Facilitator(_user!.id);
      final Room room = Room.init(roomId, facilitator);
      await RoomAdapter.instance.createRoom(room);
      return Future.value(room);
    } else {
      return Future.error('User not found');
    }
  }
}
