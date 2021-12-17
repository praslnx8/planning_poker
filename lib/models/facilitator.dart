class Facilitator {
  final String _id;

  Facilitator(this._id);

  String get id => _id;

  Facilitator.fromJson(Map<String, dynamic> json) : _id = json['id'];

  Map<String, dynamic> toJson() => {'id': _id};
}
