import 'package:planning_poker/models/user.dart';

class Estimate {
  final int estimateNo;
  final Map<User, int> pokerValueMap;

  Estimate(this.estimateNo, this.pokerValueMap);

  void addPokerValue(User user, int value) {
    pokerValueMap[user] = value;
    //TODO call adapter to publish
  }

  void listenToPokerValue() {
    //TODO Call adapter to listen
  }
}
