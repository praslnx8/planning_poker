import 'package:firebase_database/firebase_database.dart';
import 'package:planning_poker/models/estimate.dart';
import 'package:planning_poker/models/player.dart';
import 'package:planning_poker/models/room.dart';
import 'package:planning_poker/utils/console_log.dart';

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

    return Future.value('$newId');
  }

  Future<Room> getRoom(String roomNo) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref('rooms').child(roomNo);
    DataSnapshot dataSnapshot = await roomRef.get();
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
        ConsoleLog.i('room is null');
        return Transaction.abort();
      }
      Map<String, dynamic> _room = Map<String, dynamic>.from(room as Map);
      final _players = (_room['players'] != null ? _room['players'] as List : List.empty(growable: true));
      final _player =
          _players.firstWhere((element) => element != null && element['id'] == player.id, orElse: () => null);
      if (_player == null) {
        _players.add(player.toJson());
      }
      _room['players'] = _players;
      return Transaction.success(_room);
    });
    return Future.value();
  }

  Future<void> addEstimate(String roomNo, Estimate estimate) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref('rooms').child(roomNo);
    await roomRef.runTransaction((Object? room) {
      if (room == null) {
        return Transaction.abort();
      }
      Map<String, dynamic> _room = Map<String, dynamic>.from(room as Map);
      final _estimates = (_room['estimates'] != null ? (_room['estimates'] as List) : List.empty(growable: true));
      _estimates.add(estimate.toJson());
      _room['estimates'] = _estimates;

      return Transaction.success(_room);
    });
    return Future.value();
  }

  Stream<Room> listenToRoomUpdates(String roomNo) {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref('rooms').child(roomNo);
    return roomRef.onValue.map((event) {
      return Room.fromJson(event.snapshot.value as Map<String, dynamic>);
    });
  }
}
