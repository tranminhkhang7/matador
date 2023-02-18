import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/constants/constant.dart';
import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/screens/search/widgets/searched_item.dart';
import 'package:grocery_app/services/search_books_services.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/widgets/book_item_card_widget.dart';
import 'package:grocery_app/widgets/loader.dart';

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
  TextEditingController _searchController = TextEditingController();
  List<BookItem> bookList = [];
  SearchBooksService searchBooksService = SearchBooksService();

  @override
  void initState() {
    _searchController.text = widget.searchQuery;
    fetchSearchProducts();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  fetchSearchProducts() async {
    bookList = await searchBooksService.fetchSearchedProducts(
      context: context,
      searchQuery: widget.searchQuery,
    );
    setState(() {});
    //log(productList.toString());
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      RoutesHandler.SEARCH_ALL,
      arguments: query,
    );
    setState(() {});
  }

  void navigateToBookDetailScreen(BookItem b) {
    Navigator.pushNamed(
      context,
      RoutesHandler.SINGLE_PRODUCT,
      arguments: b,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          titleSpacing: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
          ),
          title: Container(
            width: MediaQuery.of(context).size.width * .75,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    alignment: Alignment.topLeft,
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        controller: _searchController,
                        onFieldSubmitted: (value) {
                          navigateToSearchScreen(value);
                        },
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          hintText: 'Search books',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: bookList.isEmpty
          ? SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                // I only need two card horizontally
                children: bookItems.asMap().entries.map<Widget>((e) {
                  BookItem bookItem = BookItem.fromMap(e.value);
                  return GestureDetector(
                    onTap: () => navigateToBookDetailScreen(bookItem),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: BookItemCardWidget(
                        item: bookItem,
                        heroSuffix: "book_item_screen",
                      ),
                    ),
                  );
                }).toList(),
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 0.0, // add some space
              ),
            )
          : SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                // I only need two card horizontally
                children: bookList.map<Widget>((e) {
                  BookItem bookItem = e;
                  return GestureDetector(
                    onTap: () => navigateToBookDetailScreen(bookItem),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: BookItemCardWidget(
                        item: bookItem,
                        heroSuffix: "explore_screen",
                      ),
                    ),
                  );
                }).toList(),
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 0.0, // add some space
              ),
            ),
    );
  }
}
