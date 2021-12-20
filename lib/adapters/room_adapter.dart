import 'package:firebase_database/firebase_database.dart';
import 'package:planning_poker/adapters/dtos/estimate_dto.dart';
import 'package:planning_poker/adapters/dtos/room_dto.dart';
import 'package:planning_poker/adapters/dtos/room_id_pool_dto.dart';
import 'package:planning_poker/utils/console_log.dart';

import 'dtos/player_dto.dart';

class RoomAdapter {
  static RoomAdapter _instance = RoomAdapter._();

  static RoomAdapter get instance => _instance;

  RoomAdapter._();

  Future<void> createRoom({required RoomDTO room}) {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref().child('rooms').child(room.id);
    return roomRef.set(room.toJson());
  }

  Future<String> getRoomId() async {
    DatabaseReference roomIdPoolRef = FirebaseDatabase.instance.ref().child('roomIdPool');
    int newId = 0;
    await roomIdPoolRef.runTransaction((Object? object) {
      if (object == null) {
        object = Map.identity();
      }
      Map<String, dynamic> _roomIdPool = Map<String, dynamic>.from(object as Map);
      RoomIdPoolDTO roomIdPool = RoomIdPoolDTO.fromJson(_roomIdPool);
      newId = roomIdPool.availableId;
      roomIdPool.availableId = newId + 1;

      return Transaction.success(roomIdPool.toJson());
    });

    return Future.value('$newId');
  }

  Future<RoomDTO> getRoom({required String roomNo}) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref().child('rooms').child(roomNo);
    DataSnapshot dataSnapshot = await roomRef.get();
    if (dataSnapshot.value != null) {
      return Future.value(RoomDTO.fromJson(dataSnapshot.value as Map<String, dynamic>));
    } else {
      return Future.error('Not found');
    }
  }

  Future addPlayer({required String roomNo, required PlayerDTO player}) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref().child('rooms').child(roomNo);
    return roomRef.runTransaction((Object? object) {
      if (object == null) {
        return Transaction.abort();
      }
      Map<String, dynamic> _room = Map<String, dynamic>.from(object as Map);
      RoomDTO room = RoomDTO.fromJson(_room);
      room.players.add(player);
      return Transaction.success(room.toJson());
    });
  }

  Future addEstimate(String roomNo, EstimateDTO estimate) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref().child('rooms').child(roomNo);
    return roomRef.runTransaction((Object? object) {
      if (object == null) {
        return Transaction.abort();
      }
      Map<String, dynamic> _room = Map<String, dynamic>.from(object as Map);
      RoomDTO room = RoomDTO.fromJson(_room);
      room.estimates.add(estimate);
      return Transaction.success(room.toJson());
    });
  }

  Stream<RoomDTO> listenToRoomUpdates(String roomNo) {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref().child('rooms').child(roomNo);
    return roomRef.onValue.map((event) {
      return RoomDTO.fromJson(event.snapshot.value as Map<String, dynamic>);
    });
  }
}
