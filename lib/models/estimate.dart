import 'package:planning_poker/models/player.dart';

class Estimate {
  final String _id;
  final Map<String, int> _pokerValueMap;

  Estimate.init(this._id) : _pokerValueMap = Map.identity();

  Estimate(this._id, this._pokerValueMap);

  void addPokerValue(Player player, int value) {
    _pokerValueMap[player.id] = value;
    //TODO call adapter to publish
  }

  void listenToPokerValue() {
    //TODO Call adapter to listen
  }

  Estimate.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _pokerValueMap = Map.fromEntries((json['pokerValues'] as List).map((e) => MapEntry(e['playerId'], e['value'])));

  Map<String, dynamic> toJson() => {
        'id': _id,
        'pokerValues': _pokerValueMap.entries.map((e) => {'playerId': e.key, 'value': e.value})
      };
}
