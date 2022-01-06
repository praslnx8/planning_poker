import 'package:planning_poker/adapters/dtos/room_dto.dart';
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
    final uid = UserAdapter.instance.getCurrentUid();
    if (uid == null) {
      final loginUid = await UserAdapter.instance.login();
      return Future.value(User(id: loginUid));
    } else {
      return Future.value(User(id: uid));
    }
  }

  Future<Room> joinRoomAsPlayer({required String roomNo}) async {
    final player = await getPlayer();
    final room = (await RoomAdapter.instance.getRoom(roomNo: roomNo)).toRoom();

    await room.join(player: player);
    return Future.value(room);
  }

  Future<Room> getRoom({required String roomNo}) async {
    await getPlayer();
    final room = (await RoomAdapter.instance.getRoom(roomNo: roomNo)).toRoom();
    return Future.value(room);
  }

  Stream<Room> listenToRoomUpdates({required String roomNo}) {
    return RoomAdapter.instance.listenToRoomUpdates(roomNo).map((roomDTO) => roomDTO.toRoom());
  }

  Future<Room> createRoom() async {
    final Facilitator facilitator = await getFacilitator();
    final roomId = await RoomAdapter.instance.getRoomId();
    final Room room = Room.init(id: roomId, facilitator: facilitator);
    await RoomAdapter.instance.createRoom(room: RoomDTO.from(room));
    return Future.value(room);
  }

  Future<Player> getPlayer() async {
    final user = await getUser();
    return Player(id: user.id);
  }

  Future<Facilitator> getFacilitator() async {
    final user = await getUser();
    return Facilitator(id: user.id);
  }

  Future addPokerValueToCurrentEstimate({required Room room, required int value}) async {
    final player = await getPlayer();
    room.addPokerValueToCurrentEstimate(player: player, value: value);
  }

  Future<bool> isUserFacilitator({required Room room}) async {
    final user = await getUser();
    return Future.value(room.facilitator.id == user.id);
  }

  bool isLoggedIn() {
    return UserAdapter.instance.getCurrentUid() != null;
  }
}
