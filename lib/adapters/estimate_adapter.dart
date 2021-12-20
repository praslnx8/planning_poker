import 'package:firebase_database/firebase_database.dart';
import 'package:planning_poker/adapters/dtos/room_dto.dart';

class EstimateAdapter {
  static EstimateAdapter _instance = EstimateAdapter._();

  static EstimateAdapter get instance => _instance;

  EstimateAdapter._();

  Future addPokerValue(
      {required String roomNo, required String estimateId, required String playerId, required int value}) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref().child('rooms').child(roomNo);
    return roomRef.runTransaction((Object? object) {
      if (object == null) {
        return Transaction.abort();
      }
      Map<String, dynamic> _room = Map<String, dynamic>.from(object as Map);
      final room = RoomDTO.fromJson(_room);
      final estimate = room.estimates.firstWhere((e) => e.id == estimateId);
      estimate.playerPokerValues[playerId] = value;

      return Transaction.success(room.toJson());
    });
  }

  Future overRideEstimatedValue({required String roomNo, required String estimateId, required int value}) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref().child('rooms').child(roomNo);
    return roomRef.runTransaction((Object? object) {
      if (object == null) {
        return Transaction.abort();
      }
      Map<String, dynamic> _room = Map<String, dynamic>.from(object as Map);
      final room = RoomDTO.fromJson(_room);
      final estimate = room.estimates.firstWhere((e) => e.id == estimateId);
      estimate.overRiddenEstimatedValue = value;

      return Transaction.success(room.toJson());
    });
  }

  Future reveal({required String roomNo, required String estimateId}) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref().child('rooms').child(roomNo);
    return await roomRef.runTransaction((Object? object) {
      if (object == null) {
        return Transaction.abort();
      }
      Map<String, dynamic> _room = Map<String, dynamic>.from(object as Map);
      final room = RoomDTO.fromJson(_room);
      final estimate = room.estimates.firstWhere((e) => e.id == estimateId);
      estimate.revealed = true;

      return Transaction.success(room.toJson());
    });
  }
}
