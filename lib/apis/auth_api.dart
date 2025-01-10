import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';

class AuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  CollectionReference get users => _store.collection('users');
  final GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();

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

  Future<User?> getCurrentUserInstance() async {
    try {
      final user = _auth.currentUser;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> readCurrentUser() async {
    final user = _auth.currentUser;
    final uid = user?.uid;
    if (uid == null) {
      print('no uid');
      return null;
    }
    try {
      final querySnapshot = await users.where('uid', isEqualTo: uid).get();
      if (querySnapshot.docs.isNotEmpty) {
        final userData = UserModel.fromJson(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
        return userData;
      } else {
        print('else case');
        return null;
      }
    } catch (e) {
      print('e $e');
      return null;
    }
  }

  Future createUser(UserModel user) async {
    final docRef = users.doc();
    try {
      await docRef.set(user.toJson());
    } catch (e) {
      print('An error occurred while creating the user: $e');
    }
  }

  Future<void> updateUser(UserModel userData) async {
    try {
      final user = _auth.currentUser;
      final uid = user?.uid;
      final querySnapshot = await users.where('uid', isEqualTo: uid).get();
      if (querySnapshot.docs.isNotEmpty) {
        final docRef = querySnapshot.docs.first.reference;
        final updateData = <String, dynamic>{};
        if (userData.disorderName != null) {
          updateData['disorderName'] = userData.disorderName;
        }
        if (userData.email != null) updateData['email'] = userData.email;
        if (userData.patientAge != null) {
          updateData['patientAge'] = userData.patientAge;
        }
        if (userData.patientGender != null) {
          updateData['patientGender'] = userData.patientGender;
        }
        if (userData.patientName != null) {
          updateData['patientName'] = userData.patientName;
        }
        if (userData.phoneNumber != null) {
          updateData['phoneNumber'] = userData.phoneNumber;
        }
        if (userData.emotion != null) {
          updateData['emotion'] = userData.emotion;
        }
        if (userData.sessionId != null) {
          updateData['sessionId'] = userData.sessionId;
        }
        if (updateData.isNotEmpty) {
          await docRef.update(updateData);
        }
      } else {
        print('No user found with uid: $uid');
      }
    } catch (e) {
      print('An error occurred while updating the user: $e');
    }
  }
}
