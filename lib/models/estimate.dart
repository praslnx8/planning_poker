import 'package:planning_poker/adapters/estimate_adapter.dart';
import 'package:planning_poker/models/player.dart';

class Estimate {
  final String _id;
  final String _roomNo;
  final Map<Player, int> _pokerValueMap;

  Estimate.init(this._id, this._roomNo) : _pokerValueMap = Map.identity();

  Estimate(this._id, this._roomNo, this._pokerValueMap);

  Future<void> addPokerValue(Player player, int value) async {
    _pokerValueMap[player] = value;
    await EstimateAdapter.instance.addPokerValue(_roomNo, _id, player, value);
  }

  List<int> getPokerValues() {
    return _pokerValueMap.entries.map((e) => e.value).toList();
  }

  Estimate.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _roomNo = json['roomNo'],
        _pokerValueMap = json['pokerValues'] != null
            ? Map.fromEntries(
                (json['pokerValues'] as List).map((e) => MapEntry(Player.fromJson(e['player']), e['value'])))
            : Map.identity();

  Map<String, dynamic> toJson() => {
        'id': _id,
        'roomNo': _roomNo,
        'pokerValues': _pokerValueMap.entries.map((e) => {'player': e.key.toJson(), 'value': e.value})
      };
}
