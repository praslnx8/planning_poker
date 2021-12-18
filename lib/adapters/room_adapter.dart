import 'package:firebase_database/firebase_database.dart';
import 'package:planning_poker/models/estimate.dart';
import 'package:planning_poker/models/player.dart';
import 'package:planning_poker/models/room.dart';

class RoomAdapter {
  static RoomAdapter _instance = RoomAdapter._();

  static RoomAdapter get instance => _instance;

  RoomAdapter._();

  Future<void> createRoom(Room room) {
    DatabaseReference roomPoolRef = FirebaseDatabase.instance.ref('rooms').child(room.id);
    return roomPoolRef.set(room.toJson());
  }

  Future<String> getRoomId() async {
    DatabaseReference roomIdPoolRef = FirebaseDatabase.instance.ref('roomIdPool');
    int newId = 0;
    await roomIdPoolRef.runTransaction((Object? roomIdPool) {
      if (roomIdPool == null) {
        roomIdPool = Map.identity();
      }
      Map<String, dynamic> _roomIdPool = Map<String, dynamic>.from(roomIdPool as Map);
      newId = (_roomIdPool['idAvailable'] ?? 0) + 1;
      _roomIdPool['idAvailable'] = newId + 1;

      // Return the new data.
      return Transaction.success(_roomIdPool);
    });

    return Future.value(newId.toString());
  }

  Future<Room> getRoom(String roomNo) async {
    DatabaseReference roomPoolRef = FirebaseDatabase.instance.ref('rooms').child(roomNo);
    DataSnapshot dataSnapshot = await roomPoolRef.get();
    if (dataSnapshot.value != null) {
      return Future.value(Room.fromJson(dataSnapshot.value as Map<String, dynamic>));
    } else {
      return Future.error('Not found');
    }
  }

  Future<void> addPlayer(String roomNo, Player player) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref('rooms').child(roomNo);
    await roomRef.runTransaction((Object? room) {
      if (room == null) {
        return Transaction.abort();
      }
      Map<String, dynamic> _room = Map<String, dynamic>.from(room as Map);
      final players = (_room['players'] != null ? _room['players'] as List : List.empty(growable: true)).toSet();
      players.add(player.toJson());

      return Transaction.success(_room);
    });
  }

  Future<void> addEstimate(String roomNo, Estimate estimate) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref('rooms').child(roomNo);
    await roomRef.runTransaction((Object? room) {
      if (room == null) {
        return Transaction.abort();
      }
      Map<String, dynamic> _room = Map<String, dynamic>.from(room as Map);
      final estimates =
          (_room['estimates'] != null ? (_room['estimates'] as List) : List.empty(growable: true)).toSet();
      estimates.add(estimate.toJson());
      _room['estimates'] = estimates;

      return Transaction.success(_room);
    });
  }

  Stream<Room> listenToRoomUpdates(String roomNo) {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref('rooms').child(roomNo);
    return roomRef.onValue.map((event) {
      return Room.fromJson(event.snapshot.value as Map<String, dynamic>);
    });
  }
}
