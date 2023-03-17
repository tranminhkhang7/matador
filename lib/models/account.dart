import 'dart:convert';

import 'package:grocery_app/models/customer.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Account {
  final String email;
  final String password;
  final String token;
  // final String name;
  // final String gender;
  // final DateTime? birthDate;
  // final String address;
  // final String phone;
  final Customer customer;
  Account({
    required this.email,
    required this.password,
    required this.token,
    required this.customer,
  });

  Account copyWith({
    String? email,
    String? password,
    String? token,
    Customer? customer,
  }) {
    return Account(
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      customer: customer ?? this.customer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'token': token,
      'customer': customer.toMap(),
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      customer: Customer.fromMap(map['customer']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Account(email: $email, password: $password, token: $token, customer: $customer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Account &&
        other.email == email &&
        other.password == password &&
        other.token == token &&
        other.customer == customer;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        token.hashCode ^
        customer.hashCode;
  }
}
