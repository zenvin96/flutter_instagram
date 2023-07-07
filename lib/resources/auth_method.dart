import "dart:typed_data";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List profileImage,
  }) async {
    String res = 'Some error occured';
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(profileImage);
      await _storage.collection('users').doc(cred.user!.uid).set({
        'username': username,
        'email': email,
        'bio': bio,
        'profileImage': profileImage,
        'followers': [],
        'following': [],
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
  // signup user
}
