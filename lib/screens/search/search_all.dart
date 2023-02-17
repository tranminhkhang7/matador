import 'package:flutter/material.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/services/search_books_services.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;
  const SearchScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<BookItem> bookList = [];
  SearchBooksService searchBooksService = SearchBooksService();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
