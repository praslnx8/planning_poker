import 'package:planning_poker/adapters/dtos/estimate_dto.dart';
import 'package:planning_poker/adapters/dtos/player_dto.dart';
import 'package:planning_poker/adapters/room_adapter.dart';
import 'package:planning_poker/models/estimate.dart';
import 'package:planning_poker/models/facilitator.dart';
import 'package:planning_poker/models/player.dart';

class Room {
  final String id;
  final Facilitator facilitator;
  final List<Estimate> estimates;
  final Set<Player> players;

  Room.init({required this.id, required this.facilitator})
      : estimates = List.empty(growable: true),
        players = Set.identity();

  Room({required this.id, required this.facilitator, required this.estimates, required this.players});

  Future join({required Player player}) async {
    this.players.add(player);
    return RoomAdapter.instance.addPlayer(roomNo: id, player: PlayerDTO.from(player));
  }

  Future<Estimate> startEstimate() async {
    final estimate = Estimate.init(id: '${estimates.length}', roomNo: id);
    estimates.add(estimate);
    await RoomAdapter.instance.addEstimate(id, EstimateDTO.from(estimate));
    return Future.value(estimate);
  }

  Estimate? getCurrentEstimate() {
    return estimates.isNotEmpty ? estimates.last : null;
  }

  int getTotalEstimates() {
    final estimatedValueList = estimates.map((e) => e.getEstimatedValue());
    return estimatedValueList.isNotEmpty ? estimatedValueList.reduce((value, element) => value + element) : 0;
  }

  int getTotalPlayers() {
    return players.length;
  }

  Future<void> revealCurrentEstimate() {
    return getCurrentEstimate()!.reveal();
  }

  Future<void> addPokerValueToCurrentEstimate({required Player player, required int value}) {
    return getCurrentEstimate()!.addPokerValue(player.id, value);
  }
}
