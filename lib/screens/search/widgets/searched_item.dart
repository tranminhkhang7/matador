import 'package:flutter/material.dart';
import 'package:grocery_app/models/book_item.dart';

class SearchedItem extends StatelessWidget {
  final BookItem book;
  const SearchedItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            book.imageLink,
            fit: BoxFit.fitHeight,
            height: 100,
            width: 100,
          ),
          Container(
            child: Text(
              book.title,
              style: const TextStyle(fontSize: 16),
              maxLines: 2,
            ),
          ),
          Container(
            child: Text(
              '\$${book.price}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
