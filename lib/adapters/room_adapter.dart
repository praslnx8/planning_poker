import 'package:firebase_database/firebase_database.dart';
import 'package:planning_poker/models/room.dart';

class RoomAdapter {
  static RoomAdapter _instance = RoomAdapter._();

  static RoomAdapter get instance => _instance;

  RoomAdapter._();

  Future<void> createRoom(Room room) {
    DatabaseReference roomIdPoolRef = FirebaseDatabase.instance.ref("room/" + room.getRoomId());
    return roomIdPoolRef.set(room);
  }

  Future<String> getRoomId() async {
    DatabaseReference roomIdPoolRef = FirebaseDatabase.instance.ref("roomIdPool");
    int newId = 0;
    await roomIdPoolRef.runTransaction((Object? roomIdPool) {
      Map<String, dynamic> _roomIdPool = Map<String, dynamic>.from(roomIdPool as Map);
      newId = (_roomIdPool['idAvailable'] ?? 0) + 1;
      _roomIdPool['idAvailable'] = newId + 1;

      // Return the new data.
      return Transaction.success(_roomIdPool);
    });

    return Future.value(newId.toString());
  }
}
