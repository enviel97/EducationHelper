class User {
  final String? id;
  final String name;
  final String email;
  final String? avatar;
  final String phoneNumber;

  const User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.avatar,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
