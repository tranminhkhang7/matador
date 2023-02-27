import 'dart:convert';
import 'package:grocery_app/models/book_item.dart';

class Cart {
  final int quantity;
  final BookItem bookDTO;
  Cart({
    required this.quantity,
    required this.bookDTO,
  });

  Cart copyWith({
    int? quantity,
    BookItem? bookDTO,
  }) {
    return Cart(
      quantity: quantity ?? this.quantity,
      bookDTO: bookDTO ?? this.bookDTO,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'bookDTO': bookDTO.toMap(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      quantity: map['quantity']?.toInt() ?? 0,
      bookDTO: BookItem.fromMap(map['bookDTO']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(quantity: $quantity, bookDTO: $bookDTO)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart &&
        other.quantity == quantity &&
        other.bookDTO == bookDTO;
  }

  @override
  int get hashCode => quantity.hashCode ^ bookDTO.hashCode;
}
