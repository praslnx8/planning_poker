import 'package:planning_poker/models/player.dart';

class PlayerDTO {
  final String id;

  PlayerDTO(this.id);

  PlayerDTO.from(Player player) : id = player.id;

  Player toPlayer() => Player(id: id);

  PlayerDTO.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> toJson() => {'id': id};
}
