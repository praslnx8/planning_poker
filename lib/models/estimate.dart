import 'package:planning_poker/adapters/estimate_adapter.dart';

class Estimate {
  final String id;
  final String roomNo;
  final String? desc;
  final Map<String, int> playerPokerValueMap;
  int? overRiddenEstimatedValue;
  bool revealed = false;

  Estimate.init({required this.id, required this.roomNo, required this.desc}) : playerPokerValueMap = Map.identity();

  Estimate(
      {required this.id,
      required this.roomNo,
      required this.desc,
      required this.playerPokerValueMap,
      required this.overRiddenEstimatedValue,
      required this.revealed});

  Future<void> addPokerValue(String playerId, int value) async {
    playerPokerValueMap[playerId] = value;
    await EstimateAdapter.instance.addPokerValue(roomNo: roomNo, estimateId: id, playerId: playerId, value: value);
  }

  List<int> getPokerValues() {
    if (revealed) {
      return playerPokerValueMap.entries.map((e) => e.value).toList();
    } else {
      return playerPokerValueMap.entries.map((e) => 0).toList();
    }
  }

  /// Override the estimated value when conflict occurs with players.
  Future<void> overRideEstimatedValue(int value) {
    overRiddenEstimatedValue = value;
    return EstimateAdapter.instance.overRideEstimatedValue(roomNo: roomNo, estimateId: id, value: value);
  }

  Future<void> reveal() {
    revealed = true;
    return EstimateAdapter.instance.reveal(roomNo: roomNo, estimateId: id);
  }

  int getEstimatedValue() {
    if (overRiddenEstimatedValue != null) {
      return overRiddenEstimatedValue!;
    }
    if (getPokerValues().isNotEmpty) {
      final totalEstimates = getPokerValues().reduce((value, element) => value + element);
      return totalEstimates ~/ getPokerValues().length;
    }
    return 0;
  }
}
