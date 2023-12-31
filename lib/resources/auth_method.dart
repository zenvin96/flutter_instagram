import "dart:typed_data";
import 'package:instagram/models/user.dart' as UserModel;
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:instagram/resources/storage_method.dart";

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  Future<UserModel.User> getUserDetails() async {
    DocumentSnapshot doc =
        await _storage.collection('users').doc(_auth.currentUser!.uid).get();
    return UserModel.User.fromJson(doc);
  }

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

      String photoUrl = await StorageMethods().uploadImageToStorage(
          'profileImages', profileImage, false, cred.user!.uid);

      // create user model
      UserModel.User user = UserModel.User(
        email: email,
        username: username,
        bio: bio,
        profileImage: photoUrl,
        uid: cred.user!.uid,
        followers: [],
        following: [],
      );

      await _storage.collection('users').doc(cred.user!.uid).set(user.toJson());
      res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        res = 'The email address is not valid.';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occured';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        res = 'The email address is not valid.';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
