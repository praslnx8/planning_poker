import 'package:planning_poker/models/user.dart';

class Estimate {
  final int _id;
  final Map<User, int> _pokerValueMap = Map.identity();

  Estimate.init(this._id);

  Estimate(this._id, Map<User, int> pokerValueMap) {
    this._pokerValueMap.addAll(pokerValueMap);
  }

  void addPokerValue(User user, int value) {
    _pokerValueMap[user] = value;
    //TODO call adapter to publish
  }

  void listenToPokerValue() {
    //TODO Call adapter to listen
  }
}
