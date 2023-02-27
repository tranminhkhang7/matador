import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Account {
  final String email;
  final String password;
  final String token;
  final String name;
  final String gender;
  final DateTime? birthDate;
  final String address;
  final String phone;
  Account({
    required this.email,
    required this.password,
    required this.token,
    required this.name,
    required this.gender,
    required this.birthDate,
    required this.address,
    required this.phone,
  });

  Account copyWith({
    String? email,
    String? password,
    String? token,
    String? name,
    String? gender,
    DateTime? birthDate,
    String? address,
    String? phone,
  }) {
    return Account(
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      address: address ?? this.address,
      phone: phone ?? this.phone,
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
      'address': address,
      'phone': phone,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      name: map['name'] ?? '',
      gender: map['gender'] ?? '',
      birthDate: map['birthDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthDate'] * 1000)
          : null,
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Account(email: $email, password: $password, token: $token, name: $name, gender: $gender, birthDate: $birthDate, address: $address, phone: $phone)';
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
        other.birthDate == birthDate &&
        other.address == address &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        token.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        birthDate.hashCode ^
        address.hashCode ^
        phone.hashCode;
  }
}
