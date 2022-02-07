import 'package:faker/faker.dart';

class Member {
  final String uid;
  final String firstName;
  final String lastName;
  final String gender;
  final String? avatar;
  final String? mail;
  final String? phoneNumber;
  final String? birth;

  const Member({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.avatar,
    this.mail,
    this.phoneNumber,
    this.birth,
  });

  String get name => '$firstName $lastName';

  static Member fromJson(dynamic json) {
    return Member(
      uid: json['id'] ?? json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      gender: json['gender'] ?? '',
      avatar: json['avatar'] ?? '',
      mail: json['mail'] ?? '',
      phoneNumber: json['phoneNumber'] ?? json['phone'] ?? '',
      birth: json['birth'] ?? json['datebirth'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'mail': mail,
        'phoneNumber': phoneNumber,
        'birth': birth,
      };

  @override
  String toString() {
    return '$firstName $lastName';
  }

  factory Member.faker() {
    final faker = Faker();
    final person = faker.person;
    final gender = person.prefix();
    return Member(
        uid: '${DateTime.now().microsecondsSinceEpoch}',
        firstName: faker.person.firstName(),
        lastName: faker.person.lastName(),
        gender: gender == 'Mr.' || gender == 'Dr' ? 'male' : 'female',
        mail: faker.internet.email(),
        phoneNumber: faker.randomGenerator.fromPattern(['077#######']),
        birth: faker.date.dateTime(minYear: 1990, maxYear: 2020).toString(),
        avatar: faker.image.image(width: 500, height: 500, random: true));
  }
}
