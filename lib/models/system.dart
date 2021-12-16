import 'package:planning_poker/adapters/room_adapter.dart';
import 'package:planning_poker/models/room.dart';

typedef RoomCreatedCallback = void Function(Room room);
typedef RoomCreateFailedCallback = void Function(String error);
typedef RoomCreateProcessingCallback = void Function();

typedef RoomJoinedCallback = void Function(Room room);
typedef RoomJoinFailedCallback = void Function(String error);
typedef RoomJoinProcessingCallback = void Function();

class System {
  void joinRoom(String roomNo,
      {required RoomJoinProcessingCallback onProcessing,
      required RoomJoinedCallback onRoomJoined,
      required RoomJoinFailedCallback onRoomJoinFailed}) {}

  void createRoom(
      {required RoomCreateProcessingCallback onProcessing,
      required RoomCreatedCallback onRoomCreated,
      required RoomCreateFailedCallback onRoomCreateFailed}) {
    onProcessing();
    final roomId = RoomAdapter.instance.createRoom();
    if (roomId != null) {
      final room = Room.init(roomId);
      onRoomCreated(room);
    } else {
      onRoomCreateFailed('error');
    }
  }
}
