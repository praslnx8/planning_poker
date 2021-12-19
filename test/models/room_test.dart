import 'package:planning_poker/models/estimate.dart';
import 'package:planning_poker/models/facilitator.dart';
import 'package:planning_poker/models/player.dart';
import 'package:planning_poker/models/room.dart';
import 'package:test/test.dart';

void main() {
  test('should load Room from json', () {
    final estimateJson = {
      'id': '1',
      'pokerValues': [
        {'playerId': 'p1', 'value': 1}
      ]
    };
    final json = {
      'id': '1',
      'facilitator': {'id': '1'},
      'estimates': [
        estimateJson
      ],
      'players': [
        {
          'id': '1',
        }
      ]
    };

    Room actual = Room.fromJson(json);

    List<Estimate> estimateList = List.empty(growable: true);
    estimateList.add(Estimate.fromJson(estimateJson));
    Set<Player> playerList = Set.identity();
    playerList.add(Player('1'));
    Room expected = Room('1', Facilitator('1'), estimateList, playerList);
    expect(actual.toJson(), expected.toJson());
  });

  test('should load Room from json When estimate and players are null', () {

    final json = {
      'id': '1',
      'facilitator': {'id': '1'},
    };

    Room actual = Room.fromJson(json);

    Room expected = Room.init('1', Facilitator('1'));
    expect(actual.toJson(), expected.toJson());
  });

  test('should have total players count', () {
    var players = [Player("p1"), Player("p2")];
    Room room = Room("1", Facilitator("0"), [], players.toSet());

    expect(room.getTotalPlayers(), 2);
  });
}
