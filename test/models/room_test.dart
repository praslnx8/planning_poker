import 'package:planning_poker/models/facilitator.dart';
import 'package:planning_poker/models/player.dart';
import 'package:planning_poker/models/room.dart';
import 'package:test/test.dart';

void main() {
  test('should have total players count', () {
    final players = List<Player>.empty(growable: true);
    players.add(Player(id: '1'));
    players.add(Player(id: '2'));
    Room room = Room(id: '1', facilitator: Facilitator(id: '0'), estimates: List.empty(), players: players.toSet());

    expect(room.getTotalPlayers(), 2);
  });
}
