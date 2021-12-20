import 'package:planning_poker/models/facilitator.dart';

class FacilitatorDTO {
  final String id;

  FacilitatorDTO(this.id);

  FacilitatorDTO.from(Facilitator facilitator) : id = facilitator.id;

  Facilitator toFacilitator() => Facilitator(id: id);

  FacilitatorDTO.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> toJson() => {'id': id};
}
