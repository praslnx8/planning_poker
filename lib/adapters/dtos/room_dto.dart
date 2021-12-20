import 'package:planning_poker/adapters/dtos/estimate_dto.dart';
import 'package:planning_poker/adapters/dtos/facilitator_dto.dart';
import 'package:planning_poker/adapters/dtos/player_dto.dart';
import 'package:planning_poker/models/room.dart';

class RoomDTO {
  final String id;
  final FacilitatorDTO facilitator;
  final List<EstimateDTO> estimates;
  final Set<PlayerDTO> players;

  RoomDTO(this.id, this.facilitator, this.estimates, this.players);

  RoomDTO.from(Room room)
      : id = room.id,
        facilitator = FacilitatorDTO.from(room.facilitator),
        estimates = room.estimates.map((e) => EstimateDTO.from(e)).toList(),
        players = room.players.map((p) => PlayerDTO.from(p)).toSet();

  Room toRoom() => Room(
      id: id,
      facilitator: facilitator.toFacilitator(),
      estimates: estimates.map((e) => e.toEstimate()).toList(growable: true),
      players: players.map((p) => p.toPlayer()).toSet());

  RoomDTO.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        facilitator = FacilitatorDTO.fromJson(json['facilitator']),
        estimates = json['estimates'] != null
            ? (json['estimates'] as List).map((e) => EstimateDTO.fromJson(e)).toList(growable: true)
            : List.empty(growable: true),
        players = json['players'] != null
            ? (json['players'] as List).map((p) => PlayerDTO.fromJson(p)).toSet()
            : Set.identity();

  Map<String, dynamic> toJson() => {
        'id': id,
        'facilitator': facilitator.toJson(),
        'estimates': estimates.map((estimate) => estimate.toJson()).toList(),
        'players': players.map((player) => player.toJson()).toList()
      };
}
