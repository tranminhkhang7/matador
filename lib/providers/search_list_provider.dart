import 'package:flutter/material.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/services/books_services.dart';

class SearchItemsProvider with ChangeNotifier {
  Future<List<BookItem>> search(BuildContext context, String query) async {
    final BooksService searchService = BooksService();
    return await searchService.fetchSearchedProducts(
      context: context,
      searchQuery: query,
    );
  }
}
