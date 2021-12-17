import 'package:planning_poker/models/estimate.dart';
import 'package:planning_poker/models/facilitator.dart';
import 'package:planning_poker/models/player.dart';
import 'package:planning_poker/models/user.dart';

class Room {
  final String _id;
  final Facilitator _facilitator;
  final List<Estimate> _estimates = List.empty(growable: true);
  final Set<Player> _players = Set.identity();

  Room.init(this._id, this._facilitator);

  Room(this._id, this._facilitator, List<Estimate> estimates, List<Player> players) {
    this._estimates.addAll(estimates);
    this._players.addAll(players);
  }

  void joinRoom(User user) {
    this._players.add(Player(user.id));
    //TODO call adapter to sync
  }

  String getRoomId() => _id;

  Estimate startEstimate() {
    final estimate = Estimate.init(_estimates.length);
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
        _facilitator = Facilitator.fromJson(json['name']);

  Map<String, dynamic> toJson() =>
      {'id': _id, 'facilitator': _facilitator.toJson(), 'estimates': _estimates.map((estimate) => estimate.toJson())};
}
