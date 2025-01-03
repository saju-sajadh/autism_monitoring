import 'package:firebase_auth/firebase_auth.dart';

class AuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();

  Future<UserCredential?> googleSignin() async {
    try {
      final userCredential =
          await _auth.signInWithProvider(_googleAuthProvider);
      return userCredential;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void googleSignout() {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      return user;
    } catch (e) {
      return null;
    }
  }
}
