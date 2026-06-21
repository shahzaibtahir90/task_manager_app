import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_internship_app/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw 'Firestore access denied. Publish security rules that allow authenticated users to write their own profile.';
      }
      throw 'Failed to save user data (${e.code}): ${e.message ?? 'Unknown error'}';
    } catch (e) {
      throw 'Failed to save user data: $e';
    }
  }

  Future<void> ensureUserProfile({
    required String uid,
    required String email,
    String? name,
    String? profileImageUrl,
  }) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) {
        await saveUserData(
          UserModel(
            uid: uid,
            name: name?.trim().isNotEmpty == true
                ? name!.trim()
                : email.split('@').first,
            email: email,
            createdAt: DateTime.now(),
            profileImageUrl: profileImageUrl,
          ),
        );
      }
    } catch (e) {
      throw 'Failed to sync user profile: $e';
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw 'Failed to fetch user data: $e';
    }
  }

  Stream<UserModel?> getUserDataStream(String uid) {
    try {
      return _firestore.collection('users').doc(uid).snapshots().map((doc) {
        if (doc.exists) {
          return UserModel.fromMap(doc.data() as Map<String, dynamic>);
        }
        return null;
      });
    } catch (e) {
      throw 'Failed to stream user data: $e';
    }
  }

  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      throw 'Failed to update user data: $e';
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
    } catch (e) {
      throw 'Failed to delete user data: $e';
    }
  }
}
