import 'package:planning_poker/adapters/dtos/estimate_dto.dart';
import 'package:test/test.dart';

void main() {
  test('should load Estimate from json', () {
    final json = {
      'id': '1',
      'roomNo': '33',
      'playerPokerValues': [
        {'playerId': 'p1', 'value': 1}
      ],
      'overRiddenEstimatedValue': 1,
      'isReveal': false
    };

    EstimateDTO actual = EstimateDTO.fromJson(json);

    expect(actual.toJson(), {
      'id': '1',
      'roomNo': '33',
      'playerPokerValues': [
        {'playerId': 'p1', 'value': 1}
      ],
      'overRiddenEstimatedValue': 1,
      'isRevealed': false
    });
  });

  test('should load Estimate from json When pokerValues are null', () {
    final json = {'id': '1', 'roomNo': '33'};

    EstimateDTO actual = EstimateDTO.fromJson(json);

    expect(actual.toJson(),
        {'id': '1', 'roomNo': '33', 'playerPokerValues': [], 'overRiddenEstimatedValue': null, 'isRevealed': false});
  });
}
