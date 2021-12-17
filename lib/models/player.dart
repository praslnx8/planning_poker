class Player {
  final String _id;

  Player(this._id);

  String get id => _id;

  Player.fromJson(Map<String, dynamic> json) : _id = json['id'];

  Map<String, dynamic> toJson() => {'id': _id};

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Player && runtimeType == other.runtimeType && _id == other._id;

  @override
  int get hashCode => _id.hashCode;
}
