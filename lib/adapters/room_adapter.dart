import 'package:firebase_database/firebase_database.dart';

class RoomAdapter {
  static RoomAdapter _instance = RoomAdapter._();

  static RoomAdapter get instance => _instance;

  RoomAdapter._();

  String? createRoom() {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref("room").push();
    ref.set({});
    return ref.key;
  }
}
