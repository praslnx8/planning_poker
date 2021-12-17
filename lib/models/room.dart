import 'package:planning_poker/adapters/room_adapter.dart';
import 'package:planning_poker/models/estimate.dart';
import 'package:planning_poker/models/facilitator.dart';
import 'package:planning_poker/models/player.dart';
import 'package:planning_poker/models/user.dart';

class Room {
  final String _id;
  final Facilitator _facilitator;
  final List<Estimate> _estimates;
  final Set<Player> _players;

  Room.init(this._id, this._facilitator)
      : _estimates = List.empty(growable: true),
        _players = Set.identity();

  Room(this._id, this._facilitator, this._estimates, this._players);

  Future<void> joinRoom(User user) async {
    final player = Player(user.id);
    this._players.add(player);
    return RoomAdapter.instance.addPlayer(id, player);
  }

  String get id => _id;

  Estimate startEstimate() {
    final estimate = Estimate.init(_estimates.length.toString());
    _estimates.add(estimate);
    //TODO sync room
    return estimate;
  }

  Estimate? getCurrentEstimate() {
    return _estimates.last;
  }

  void listenToEstimate() {
    //TODO listen to estimate and broadcast
  }

  Room.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _facilitator = Facilitator.fromJson(json['facilitator']),
        _estimates = json['estimates'] != null
            ? (json['estimates'] as List)
                .map((e) => Estimate.fromJson(e as Map<String, dynamic>))
                .toList(growable: true)
            : List.empty(growable: true),
        _players = json['players'] != null
            ? (json['players'] as List).map((e) => Player.fromJson(e as Map<String, dynamic>)).toSet()
            : Set.identity();

  Map<String, dynamic> toJson() => {
        'id': _id,
        'facilitator': _facilitator.toJson(),
        'estimates': _estimates.map((estimate) => estimate.toJson()),
        'players': _players.map((player) => player.toJson())
      };
}
