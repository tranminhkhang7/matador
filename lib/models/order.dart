import 'dart:convert';

class Order {
  final String address;
  final String phone;
  final String status;
  final DateTime time;
  final double totalAmount;
  Order({
    required this.address,
    required this.phone,
    required this.status,
    required this.time,
    required this.totalAmount,
  });

  Order copyWith({
    String? address,
    String? phone,
    String? status,
    DateTime? time,
    double? totalAmount,
  }) {
    return Order(
      address: address ?? this.address,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      time: time ?? this.time,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'phone': phone,
      'status': status,
      'time': time.millisecondsSinceEpoch,
      'total_amount': totalAmount,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      status: map['status'] ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(
          DateTime.parse(map['time']).millisecondsSinceEpoch),
      totalAmount: map['total_amount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(address: $address, phone: $phone, status: $status, time: $time, total_amount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.address == address &&
        other.phone == phone &&
        other.status == status &&
        other.time == time &&
        other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        phone.hashCode ^
        status.hashCode ^
        time.hashCode ^
        totalAmount.hashCode;
  }
}
