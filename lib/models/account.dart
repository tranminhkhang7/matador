import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Account {
  final String email;
  final String password;
  final String token;
  final String name;
  final String gender;
  final DateTime? birthDate;
  Account({
    required this.email,
    required this.password,
    required this.token,
    required this.name,
    required this.gender,
    required this.birthDate,
  });

  Account copyWith({
    String? email,
    String? password,
    String? token,
    String? name,
    String? gender,
    DateTime? birthDate,
  }) {
    return Account(
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'token': token,
      'name': name,
      'gender': gender,
      'birthDate': birthDate?.millisecondsSinceEpoch,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      name: map['name'] ?? '',
      gender: map['gender'] ?? '',
      birthDate: DateTime.fromMillisecondsSinceEpoch(map['birthDate'] * 1000),
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Account(email: $email, password: $password, token: $token, name: $name, gender: $gender, birthDate: $birthDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Account &&
        other.email == email &&
        other.password == password &&
        other.token == token &&
        other.name == name &&
        other.gender == gender &&
        other.birthDate == birthDate;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        token.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        birthDate.hashCode;
  }
}
