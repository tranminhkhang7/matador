import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:grocery_app/models/book_item.dart';

class Cart {
  final int id;
  final int quantity;
  final int bookId;
  final int customerId;
  final List<BookItem> cartItems;
  Cart({
    required this.id,
    required this.quantity,
    required this.bookId,
    required this.customerId,
    required this.cartItems,
  });

  Cart copyWith({
    int? id,
    int? quantity,
    int? bookId,
    int? customerId,
    List<BookItem>? cartItems,
  }) {
    return Cart(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      bookId: bookId ?? this.bookId,
      customerId: customerId ?? this.customerId,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'bookId': bookId,
      'customerId': customerId,
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      bookId: map['bookId']?.toInt() ?? 0,
      customerId: map['customerId']?.toInt() ?? 0,
      cartItems: List<BookItem>.from(
          map['cartItems']?.map((x) => BookItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cart(id: $id, quantity: $quantity, bookId: $bookId, customerId: $customerId, cartItems: $cartItems)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart &&
        other.id == id &&
        other.quantity == quantity &&
        other.bookId == bookId &&
        other.customerId == customerId &&
        listEquals(other.cartItems, cartItems);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        quantity.hashCode ^
        bookId.hashCode ^
        customerId.hashCode ^
        cartItems.hashCode;
  }
}
