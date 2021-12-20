import 'package:planning_poker/adapters/room_adapter.dart';
import 'package:planning_poker/adapters/user_adapter.dart';
import 'package:planning_poker/models/facilitator.dart';
import 'package:planning_poker/models/player.dart';
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

  Future<User> getUser() async {
    final uid = await UserAdapter.instance.getCurrentUid();
    if (uid == null) {
      final loginUid = await UserAdapter.instance.login();
      return Future.value(User(loginUid));
    } else {
      return Future.value(User(uid));
    }
  }

  Future<Room> joinRoomAsPlayer(String roomNo) async {
    final player = await getPlayer();
    final room = await RoomAdapter.instance.getRoom(roomNo);

    await room.joinRoom(player);
    return Future.value(room);
  }

  Future<Stream<Room>> listenToRoomUpdates(String roomNo) async {
    final player = await getPlayer();
    final room = await RoomAdapter.instance.getRoom(roomNo);
    if (!(await isUserFacilitator(room))) {
      await room.joinRoom(player);
    }
    return Future.value(RoomAdapter.instance.listenToRoomUpdates(roomNo));
  }

  Future<Room> createRoom() async {
    final Facilitator facilitator = await getFacilitator();
    final roomId = await RoomAdapter.instance.getRoomId();
    final Room room = Room.init(roomId, facilitator);
    await RoomAdapter.instance.createRoom(room);
    return Future.value(room);
  }

  Future<Player> getPlayer() async {
    final user = await getUser();
    return Player(user.id);
  }

  Future<Facilitator> getFacilitator() async {
    final user = await getUser();
    return Facilitator(user.id);
  }

  Future addPokerValueToCurrentEstimate(Room room, int value) async {
    final player = await getPlayer();
    room.addPokerValueToCurrentEstimate(player, value);
  }

  Future<bool> isUserFacilitator(Room room) async {
    final user = await getUser();
    return Future.value(room.facilitator.id == user.id);
  }
}
