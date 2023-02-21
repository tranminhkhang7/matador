import 'dart:convert';

class BookItem {
  final int bookId;
  final String author;
  final String description;
  final String imageLink;
  final double price;
  final String publisher;
  final String quantityLeft;
  final String status;
  final String title;
  BookItem({
    required this.bookId,
    required this.author,
    required this.description,
    required this.imageLink,
    required this.price,
    required this.publisher,
    required this.quantityLeft,
    required this.status,
    required this.title,
  });

  BookItem copyWith({
    int? bookId,
    String? author,
    String? description,
    String? imageLink,
    double? price,
    String? publisher,
    String? quantityLeft,
    String? status,
    String? title,
  }) {
    return BookItem(
      bookId: bookId ?? this.bookId,
      author: author ?? this.author,
      description: description ?? this.description,
      imageLink: imageLink ?? this.imageLink,
      price: price ?? this.price,
      publisher: publisher ?? this.publisher,
      quantityLeft: quantityLeft ?? this.quantityLeft,
      status: status ?? this.status,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'author': author,
      'description': description,
      'imageLink': imageLink,
      'price': price,
      'publisher': publisher,
      'quantityLeft': quantityLeft,
      'status': status,
      'title': title,
    };
  }

  factory BookItem.fromMap(Map<String, dynamic> map) {
    return BookItem(
      bookId: map['bookId']?.toInt() ?? 0,
      author: map['author'] ?? '',
      description: map['description'] ?? '',
      imageLink: map['imageLink'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      publisher: map['publisher'] ?? '',
      quantityLeft: map['quantityLeft'] ?? '',
      status: map['status'] ?? '',
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BookItem.fromJson(String source) =>
      BookItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookItem(id: $bookId, author: $author, description: $description, imageLink: $imageLink, price: $price, publisher: $publisher, quantityLeft: $quantityLeft, status: $status, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookItem &&
        other.bookId == bookId &&
        other.author == author &&
        other.description == description &&
        other.imageLink == imageLink &&
        other.price == price &&
        other.publisher == publisher &&
        other.quantityLeft == quantityLeft &&
        other.status == status &&
        other.title == title;
  }

  @override
  int get hashCode {
    return bookId.hashCode ^
        author.hashCode ^
        description.hashCode ^
        imageLink.hashCode ^
        price.hashCode ^
        publisher.hashCode ^
        quantityLeft.hashCode ^
        status.hashCode ^
        title.hashCode;
  }
}
