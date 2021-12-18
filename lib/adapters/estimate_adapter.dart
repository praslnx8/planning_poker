import 'package:firebase_database/firebase_database.dart';
import 'package:planning_poker/models/player.dart';

class EstimateAdapter {
  static EstimateAdapter _instance = EstimateAdapter._();

  static EstimateAdapter get instance => _instance;

  EstimateAdapter._();

  Future<void> addPokerValue(String roomNo, String estimateId, Player player, int pokerValue) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref('rooms').child(roomNo);
    await roomRef.runTransaction((Object? room) {
      if (room == null) {
        return Transaction.abort();
      }
      Map<String, dynamic> _room = Map<String, dynamic>.from(room as Map);
      Map<String, dynamic> _estimate = getEstimateFromRoom(_room, estimateId);

      final pokerValueMap = _estimate['_pokerValueMap'] != null ? (_estimate['_pokerValueMap'] as Map) : Map.identity();
      pokerValueMap.putIfAbsent(player.toJson(), () => pokerValue);
      _estimate['pokerValueMap'] = pokerValueMap;

      return Transaction.success(_room);
    });
  }

  Future<void> overRideEstimatedValue(String roomNo, String estimateId, int value) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref('rooms').child(roomNo);
    await roomRef.runTransaction((Object? room) {
      if (room == null) {
        return Transaction.abort();
      }
      Map<String, dynamic> _room = Map<String, dynamic>.from(room as Map);
      Map<String, dynamic> _estimate = getEstimateFromRoom(_room, estimateId);

      _estimate['overRideEstimatedValue'] = value;

      return Transaction.success(_room);
    });
  }

  Future<void> reveal(String roomNo, String estimateId) async {
    DatabaseReference roomRef = FirebaseDatabase.instance.ref('rooms').child(roomNo);
    await roomRef.runTransaction((Object? room) {
      if (room == null) {
        return Transaction.abort();
      }
      Map<String, dynamic> _room = Map<String, dynamic>.from(room as Map);
      Map<String, dynamic> _estimate = getEstimateFromRoom(_room, estimateId);

      _estimate['reveal'] = true;

      return Transaction.success(_room);
    });
  }

  Map<String, dynamic> getEstimateFromRoom(Map<String, dynamic> _room, String estimateId) {
    final estimates = (_room['estimates'] != null ? (_room['estimates'] as List) : List.empty(growable: true)).toSet();
    final _estimate = estimates.firstWhere((element) => element['id'] == estimateId);
    return _estimate;
  }
}
