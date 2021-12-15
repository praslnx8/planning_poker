import 'package:planning_poker/models/estimate.dart';
import 'package:planning_poker/models/user.dart';

class Room {
  List<Estimate> _estimates = List.empty(growable: true);
  List<User> _users = List.empty(growable: true);

  Room.init();

  Room(List<Estimate> estimates, List<User> users) {
    this._estimates = List.of(estimates, growable: true);
    this._users = List.of(users, growable: true);
  }
}
