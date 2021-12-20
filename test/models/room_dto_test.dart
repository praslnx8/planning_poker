import 'package:planning_poker/adapters/dtos/room_dto.dart';
import 'package:test/test.dart';

void main() {
  test('should load Room from json', () {
    final json = {
      'id': '1',
      'facilitator': {'id': '1'},
      'estimates': [
        {
          'id': '1',
          'roomNo': '33',
          'pokerValues': [
            {'playerId': 'p1', 'value': 1}
          ]
        }
      ],
      'players': [
        {
          'id': '1',
        }
      ]
    };

    RoomDTO actual = RoomDTO.fromJson(json);

    expect(actual.toJson(), {
      'id': '1',
      'facilitator': {'id': '1'},
      'estimates': [
        {'id': '1', 'roomNo': '33', 'playerPokerValues': [], 'overRiddenEstimatedValue': null, 'isRevealed': false}
      ],
      'players': [
        {'id': '1'}
      ]
    });
  });

  test('should load Room from json When estimate and players are null', () {
    final json = {
      'id': '1',
      'facilitator': {'id': '1'},
    };

    RoomDTO actual = RoomDTO.fromJson(json);

    expect(actual.toJson(), {
      'id': '1',
      'facilitator': {'id': '1'},
      'estimates': [],
      'players': []
    });
  });
}
