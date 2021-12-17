import 'package:planning_poker/models/player.dart';

class Estimate {
  final String _id;
  final Map<Player, int> _pokerValueMap;

  Estimate.init(this._id) : _pokerValueMap = Map.identity();

  Estimate(this._id, this._pokerValueMap);

  void addPokerValue(Player player, int value) {
    _pokerValueMap[player] = value;
    //TODO call adapter to publish
  }

  void listenToPokerValue() {
    //TODO Call adapter to listen
  }

  Estimate.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _pokerValueMap = json['pokerValues'] != null
            ? Map.fromEntries(
                (json['pokerValues'] as List).map((e) => MapEntry(Player.fromJson(e['player']), e['value'])))
            : Map.identity();

  Map<String, dynamic> toJson() => {
        'id': _id,
        'pokerValues': _pokerValueMap.entries.map((e) => {'player': e.key, 'value': e.value})
      };
}
