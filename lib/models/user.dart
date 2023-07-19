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
