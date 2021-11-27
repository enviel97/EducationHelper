class User {
  final String displayName;
  final String username;
  final String email;
  final String avatar;

  const User({
    required this.displayName,
    required this.username,
    required this.email,
    required this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'display_name': displayName,
      'username': username,
      'email': email,
      'avatar': avatar,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      displayName: json['display_name'],
      username: json['username'],
      email: json['email'],
      avatar: json['avatar'] ?? '',
    );
  }
}
