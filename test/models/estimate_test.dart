import 'package:planning_poker/models/estimate.dart';
import 'package:test/test.dart';

void main() {
  test('should get estimated value', () {
    final playerPokerValueMap = Map<String, int>.identity();
    playerPokerValueMap['p1'] = 5;
    playerPokerValueMap['p2'] = 3;
    Estimate estimate = new Estimate(
        id: 'id',
        roomNo: 'roomNo',
        playerPokerValueMap: playerPokerValueMap,
        overRiddenEstimatedValue: null,
        revealed: true);
    expect(estimate.getEstimatedValue(), 4);
  });

  test('should get estimated value as 0 when no estimates are present', () {
    Estimate estimate = new Estimate(
        id: 'id',
        roomNo: 'roomNo',
        playerPokerValueMap: Map.identity(),
        overRiddenEstimatedValue: null,
        revealed: true);

    expect(estimate.getEstimatedValue(), 0);
  });
}
