import 'package:firebase_auth/firebase_auth.dart';

class UserAdapter {
  static UserAdapter _instance = UserAdapter._();

  static UserAdapter get instance => _instance;

  UserAdapter._();

  Future<String> login() async {
    final UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    final uid = userCredential.user?.uid;

    if (uid != null) {
      return Future.value(uid);
    } else {
      return Future.error('unable to login');
    }
  }

  Future<String?> getCurrentUid() async {
    return Future.value(FirebaseAuth.instance.currentUser?.uid);
  }
}
