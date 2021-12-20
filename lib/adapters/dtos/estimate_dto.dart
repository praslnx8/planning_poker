import 'package:planning_poker/models/estimate.dart';

class EstimateDTO {
  final String id;
  final String roomNo;
  final Map<String, int> playerPokerValues;
  int? overRiddenEstimatedValue;
  bool revealed;

  EstimateDTO(
      {required this.id,
      required this.roomNo,
      required this.playerPokerValues,
      required this.overRiddenEstimatedValue,
      required this.revealed});

  EstimateDTO.from(Estimate estimate)
      : id = estimate.id,
        roomNo = estimate.roomNo,
        playerPokerValues = estimate.playerPokerValueMap,
        overRiddenEstimatedValue = estimate.overRiddenEstimatedValue,
        revealed = estimate.revealed;

  Estimate toEstimate() => Estimate(
      id: id,
      roomNo: roomNo,
      playerPokerValueMap: playerPokerValues,
      overRiddenEstimatedValue: overRiddenEstimatedValue,
      revealed: revealed);

  EstimateDTO.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        roomNo = json['roomNo'],
        playerPokerValues = json['playerPokerValues'] != null
            ? Map.fromEntries((json['playerPokerValues'] as List).map((p) => MapEntry(p['playerId'], p['value'])))
            : Map.identity(),
        overRiddenEstimatedValue = json['overRiddenEstimatedValue'],
        revealed = json['revealed'] != null ? json['revealed'] : false;

  Map<String, dynamic> toJson() => {
        'id': id,
        'roomNo': roomNo,
        'playerPokerValues': playerPokerValues.entries.map((e) => {'playerId': e.key, 'value': e.value}).toList(),
        'overRiddenEstimatedValue': overRiddenEstimatedValue,
        'revealed': revealed
      };
}
