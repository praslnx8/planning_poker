class Facilitator {
  final String id;

  Facilitator({required this.id});

  Facilitator.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> toJson() => {'id': id};
}
