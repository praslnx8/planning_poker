import 'package:planning_poker/models/estimate.dart';
import 'package:planning_poker/models/user.dart';

class Room {
  final String _id;
  final List<Estimate> _estimates = List.empty(growable: true);
  final Set<User> _users = Set.identity();

  Room.init(this._id);

  Room(this._id, List<Estimate> estimates, List<User> users) {
    this._estimates.addAll(estimates);
    this._users.addAll(users);
  }

  void joinRoom(User user) {
    this._users.add(user);
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
}
