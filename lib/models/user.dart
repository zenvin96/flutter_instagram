import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email, username, bio, profileImage, uid;
  final List followers, following;

  const User({
    required this.email,
    required this.username,
    required this.bio,
    required this.profileImage,
    required this.uid,
    required this.followers,
    required this.following,
  });

  static User fromJson(DocumentSnapshot json) {
    var snapshot = json.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
      username: snapshot['username'],
      bio: snapshot['bio'],
      profileImage: snapshot['profileImage'],
      uid: snapshot['uid'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'bio': bio,
        'profileImage': profileImage,
        'uid': uid,
        'followers': followers,
        'following': following,
      };
}
