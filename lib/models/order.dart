import 'dart:convert';

class Order {
  final int id;
  final String address;
  final String phone;
  final String status;
  final DateTime time;
  final double totalAmount;
  Order({
    required this.id,
    required this.address,
    required this.phone,
    required this.status,
    required this.time,
    required this.totalAmount,
  });

  Order copyWith({
    int? id,
    String? address,
    String? phone,
    String? status,
    DateTime? time,
    double? totalAmount,
  }) {
    return Order(
      id: id ?? this.id,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      time: time ?? this.time,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': id,
      'address': address,
      'phone': phone,
      'status': status,
      'time': time.millisecondsSinceEpoch,
      'total_amount': totalAmount,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['orderId']?.toInt() ?? 0,
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
    return 'Order(id: $id, address: $address, phone: $phone, status: $status, time: $time, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.address == address &&
        other.phone == phone &&
        other.status == status &&
        other.time == time &&
        other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        status.hashCode ^
        time.hashCode ^
        totalAmount.hashCode;
  }
}
