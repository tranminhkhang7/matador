import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:grocery_app/models/comment.dart';
import 'package:grocery_app/models/genre.dart';

class BookItem {
  final int bookId;
  final String author;
  final String description;
  final String imageLink;
  final double price;
  final String publisher;
  final int quantityLeft;
  final String status;
  final String title;
  final List<Genre>? genreName;
  final List<Comment>? comment;
  final double? rating;
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
    this.genreName,
    this.comment,
    this.rating,
  });

  BookItem copyWith({
    int? bookId,
    String? author,
    String? description,
    String? imageLink,
    double? price,
    String? publisher,
    int? quantityLeft,
    String? status,
    String? title,
    List<Genre>? genreName,
    List<Comment>? comment,
    double? rating,
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
      genreName: genreName ?? this.genreName,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
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
      'genreName': genreName?.map((x) => x.toMap()).toList(),
      'comment': comment?.map((x) => x.toMap()).toList(),
      'rating': rating,
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
      quantityLeft: map['quantityLeft']?.toInt() ?? 0,
      status: map['status'] ?? '',
      title: map['title'] ?? '',
      genreName: map['genreName'] != null
          ? List<Genre>.from(map['genreName']?.map((x) => Genre.fromMap(x)))
          : null,
      comment: map['comment'] != null
          ? List<Comment>.from(map['comment']?.map((x) => Comment.fromMap(x)))
          : null,
      rating: map['rating']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookItem.fromJson(String source) =>
      BookItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookItem(bookId: $bookId, author: $author, description: $description, imageLink: $imageLink, price: $price, publisher: $publisher, quantityLeft: $quantityLeft, status: $status, title: $title, genreName: $genreName, comment: $comment, rating: $rating)';
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
        other.title == title &&
        listEquals(other.genreName, genreName) &&
        listEquals(other.comment, comment) &&
        other.rating == rating;
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
        title.hashCode ^
        genreName.hashCode ^
        comment.hashCode ^
        rating.hashCode;
  }
}
