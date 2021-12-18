import 'package:planning_poker/models/estimate.dart';
import 'package:planning_poker/models/player.dart';
import 'package:test/test.dart';

void main() {
  test('should load Estimate from json', () {
    final json = {
      'id': '1',
      'roomNo': '33',
      'pokerValues': [
        {
          'player': {'id': 'p1'},
          'value': 1
        }
      ],
      'overRideEstimatedValue': 1,
      'reveal': false
    };

    Estimate actual = Estimate.fromJson(json);

    Map<Player, int> pokerValueMap = Map.identity();
    pokerValueMap[Player('p1')] = 1;
    Estimate expected = Estimate('1', '33', pokerValueMap, 1);
    expect(actual.toJson(), expected.toJson());
  });

  test('should load Estimate from json When pokerValues are null', () {
    final json = {'id': '1', 'roomNo': '33'};

    Estimate actual = Estimate.fromJson(json);

    Estimate expected = Estimate.init('1', '33');
    expect(actual.toJson(), expected.toJson());
  });
}
