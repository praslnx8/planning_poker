class Player {
  final String id;

  Player({required this.id});

  Player.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> toJson() => {'id': id};

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Player && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
