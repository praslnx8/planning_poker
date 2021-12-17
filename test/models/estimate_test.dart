import 'package:planning_poker/models/estimate.dart';
import 'package:test/test.dart';

void main() {
  test('should load Estimate from json', () {
    final json = {
      'id': 1,
      'pokerValues': [
        {'playerId': 'p1', 'value': 1}
      ]
    };

    Estimate actual = Estimate.fromJson(json);

    Map<String, int> pokerValueMap = Map.identity();
    pokerValueMap['p1'] = 1;
    Estimate expected = Estimate(1, pokerValueMap);
    expect(actual.toJson(), expected.toJson());
  });
}
