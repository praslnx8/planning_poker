import 'package:planning_poker/adapters/estimate_adapter.dart';
import 'package:planning_poker/models/player.dart';

class Estimate {
  final String _id;
  final String _roomNo;
  final Map<Player, int> _pokerValueMap;
  int? _overRideEstimatedValue;
  bool _reveal = false;

  Estimate.init(this._id, this._roomNo) : _pokerValueMap = Map.identity();

  Estimate(this._id, this._roomNo, this._pokerValueMap, this._overRideEstimatedValue);

  Future<void> addPokerValue(Player player, int value) async {
    _pokerValueMap[player] = value;
    await EstimateAdapter.instance.addPokerValue(_roomNo, _id, player, value);
  }

  List<int> getPokerValues() {
    if (_reveal) {
      return _pokerValueMap.entries.map((e) => e.value).toList();
    } else {
      return _pokerValueMap.entries.map((e) => 0).toList();
    }
  }

  /// Override the estimated value when conflict occurs with players.
  Future<void> overRideEstimatedValue(int value) {
    _overRideEstimatedValue = value;
    return EstimateAdapter.instance.overRideEstimatedValue(_roomNo, _id, value);
  }

  Future<void> reveal() {
    _reveal = true;
    return EstimateAdapter.instance.reveal(_roomNo, _id);
  }

  int getEstimatedValue() {
    if (_overRideEstimatedValue != null) {
      return _overRideEstimatedValue!;
    }

    return getPokerValues().reduce((value, element) => value + element);
  }

  bool get isRevealed => _reveal;

  Estimate.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _roomNo = json['roomNo'],
        _pokerValueMap = (json['pokerValues'] != null
            ? Map.fromEntries(
                (json['pokerValues'] as List).map((e) => MapEntry(Player.fromJson(e['player']), e['value'])))
            : Map.identity()),
        _overRideEstimatedValue = json['overRideEstimatedValue'],
        _reveal = json['reveal'] != null ? json['reveal'] : false;

  Map<String, dynamic> toJson() => {
        'id': _id,
        'roomNo': _roomNo,
        'pokerValues': _pokerValueMap.entries.map((e) => {'player': e.key.toJson(), 'value': e.value}),
        'overRideEstimatedValue': _overRideEstimatedValue,
        'reveal': _reveal
      };
}
