import 'dart:convert';

class BookItem {
  final int id;
  final String author;
  final String description;
  final String imageLink;
  final double price;
  final String publisher;
  final int quantityLeft;
  final String status;
  final String title;
  BookItem({
    required this.id,
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
    int? id,
    String? author,
    String? description,
    String? imageLink,
    double? price,
    String? publisher,
    int? quantityLeft,
    String? status,
    String? title,
  }) {
    return BookItem(
      id: id ?? this.id,
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
      'id': id,
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
      id: map['id']?.toInt() ?? 0,
      author: map['author'] ?? '',
      description: map['description'] ?? '',
      imageLink: map['imageLink'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      publisher: map['publisher'] ?? '',
      quantityLeft: map['quantityLeft']?.toInt() ?? 0,
      status: map['status'] ?? '',
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BookItem.fromJson(String source) =>
      BookItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookItem(id: $id, author: $author, description: $description, imageLink: $imageLink, price: $price, publisher: $publisher, quantityLeft: $quantityLeft, status: $status, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookItem &&
        other.id == id &&
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
    return id.hashCode ^
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
