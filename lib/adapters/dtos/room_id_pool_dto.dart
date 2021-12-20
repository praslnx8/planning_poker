class RoomIdPoolDTO {
  int availableId;

  RoomIdPoolDTO({required this.availableId});

  RoomIdPoolDTO.fromJson(Map<String, dynamic> json)
      : availableId = json['availableId'] != null ? json['availableId'] : 0;

  Map<String, dynamic> toJson() => {'availableId': availableId};
}
