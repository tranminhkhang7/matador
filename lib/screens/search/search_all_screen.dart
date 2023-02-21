import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/screens/home/search_delegate.dart';
import 'package:grocery_app/screens/search/widgets/search_drawers.dart';
import 'package:grocery_app/services/books_services.dart';
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
  ScrollController scrollController = ScrollController();
  List<BookItem> bookList = [];
  List<BookItem> displayBooks = [];
  BooksService searchBooksService = BooksService();

  int page = 1;
  static final int _pageLimit = 6;
  @override
  void initState() {
    if (mounted) {
      _searchController.text = widget.searchQuery;
      scrollController = ScrollController()..addListener(_scrollListener);
      fetchSearchProducts();
    }

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  fetchSearchProducts() async {
    bookList = await searchBooksService.fetchSearchedProducts(
      context: context,
      searchQuery: widget.searchQuery,
    );

    displayBooks = bookList
        .skip((_pageLimit * page) - _pageLimit)
        .take(_pageLimit)
        .toList();
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

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      Future.delayed(
        const Duration(seconds: 5),
        () {
          if (mounted) {
            setState(
              () {
                page++;
                displayBooks.addAll(bookList
                    .skip((_pageLimit * page) - _pageLimit)
                    .take(_pageLimit)
                    .toList());
              },
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const FiltersDrawer(
        maxPrice: 1000,
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          actions: [
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.filter_list,
                  size: 30,
                ),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              );
            })
          ],
          elevation: 0,
          titleSpacing: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
          ),
          title: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: SearchBookDelegate(),
                        );
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _searchController,
                          // onFieldSubmitted: (value) {
                          //   navigateToSearchScreen(value);
                          // },
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
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
                ),
              ],
            ),
          ),
        ),
      ),
      body: bookList.isEmpty
          ? const Loader()
          : Scrollbar(
              child: SingleChildScrollView(
                controller: scrollController,
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  children: displayBooks.map<Widget>((e) {
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
            ),
    );
  }
}
