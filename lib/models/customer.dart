import 'dart:convert';

class Customer {
  final String name;
  final String gender;
  final String? address;
  final String? phone;
  final DateTime? birthday;
  Customer({
    required this.name,
    required this.gender,
    required this.address,
    required this.phone,
    this.birthday,
  });

  Customer copyWith({
    String? name,
    String? gender,
    String? address,
    String? phone,
    DateTime? birthday,
  }) {
    return Customer(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'address': address,
      'phone': phone,
      'birthday': birthday != null
          ? DateTime.fromMillisecondsSinceEpoch(
              DateTime.parse(birthday.toString()).millisecondsSinceEpoch,
            ).toString()
          : null,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      name: map['name'] ?? '',
      gender: map['gender'] ?? '',
      address: map['address'],
      phone: map['phone'],
      birthday: map['birthday'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              DateTime.parse(map['birthday']).millisecondsSinceEpoch,
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(name: $name, gender: $gender, address: $address, phone: $phone, birthday: $birthday)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Customer &&
        other.name == name &&
        other.gender == gender &&
        other.address == address &&
        other.phone == phone &&
        other.birthday == birthday;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        gender.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        birthday.hashCode;
  }
}
