class User {
  final String? id;
  final String name;
  final String email;
  final String? userType;
  final String phoneNumber;
  final String? password;

  const User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.userType,
    this.password,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userType: json['userType'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
