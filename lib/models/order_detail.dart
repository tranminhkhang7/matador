import 'dart:convert';

import 'package:grocery_app/models/book_item.dart';

class OrderDetail {
  final double price;
  final int quantity;
  final BookItem book;
  OrderDetail({
    required this.price,
    required this.quantity,
    required this.book,
  });

  OrderDetail copyWith({
    double? price,
    int? quantity,
    BookItem? book,
  }) {
    return OrderDetail(
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      book: book ?? this.book,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'quantity': quantity,
      'book': book.toMap(),
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      book: BookItem.fromMap(map['book']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) =>
      OrderDetail.fromMap(json.decode(source));

  @override
  String toString() =>
      'OrderDetail(price: $price, quantity: $quantity, book: $book)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDetail &&
        other.price == price &&
        other.quantity == quantity &&
        other.book == book;
  }

  @override
  int get hashCode => price.hashCode ^ quantity.hashCode ^ book.hashCode;
}
