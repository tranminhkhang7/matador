import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/services/search_books_services.dart';

class SearchItemsProvider with ChangeNotifier {
  Future<List<BookItem>> search(BuildContext context, String query) async {
    final searchService = SearchBooksService();
    return await searchService.fetchSearchedProducts(
      context: context,
      searchQuery: query,
    );
  }
}
