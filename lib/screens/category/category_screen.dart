import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/models/genre.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/product_details/book_detail_screen.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/services/books_services.dart';
import 'package:grocery_app/widgets/book_item_card_widget.dart';

class CategoryItemsScreen extends StatefulWidget {
  final Genre genre;
  const CategoryItemsScreen({
    super.key,
    required this.genre,
  });
  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  final BooksService booksService = BooksService();
  // List<BookItem> booksByGenre = [];

  // fetchBooksByCategory() async {
  //   booksByGenre = await booksService.fetchCategoryBooks(
  //     context: context,
  //     categoryId: widget.genre.genreId,
  //   );
  //   setState(() {});
  // }

  @override
  void initState() {
    //fetchBooksByCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.only(left: 25),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => FilterScreen()),
                // );
              },
              child: Container(
                padding: EdgeInsets.only(right: 25),
                child: Icon(
                  Icons.sort,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          title: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: AppText(
              text: widget.genre.genreName,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: FutureBuilder<List<BookItem>>(
          future: booksService.fetchCategoryBooks(
            context: context,
            categoryId: widget.genre.genreId,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<BookItem> booksByGenre = snapshot.data!;
              return SingleChildScrollView(
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  children: booksByGenre.map((bookItem) {
                    return GestureDetector(
                      onTap: () {
                        onItemClicked(context, bookItem);
                      },
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
                  crossAxisSpacing: 0.0,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )

        // SingleChildScrollView(
        //   child: StaggeredGrid.count(
        //     crossAxisCount: 2,
        //     // I only need two card horizontally
        //     children: booksByGenre.asMap().entries.map<Widget>((e) {
        //       BookItem bookItem = e.value;
        //       return GestureDetector(
        //         onTap: () {
        //           onItemClicked(context, bookItem);
        //         },
        //         child: Container(
        //           padding: EdgeInsets.all(10),
        //           child: BookItemCardWidget(
        //             item: bookItem,
        //             heroSuffix: "explore_screen",
        //           ),
        //         ),
        //       );
        //     }).toList(),
        //     mainAxisSpacing: 3.0,
        //     crossAxisSpacing: 0.0, // add some space
        //   ),
        // ),
        );
  }

  void onItemClicked(BuildContext context, BookItem bookItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailScreen(
          bookItem: bookItem,
          heroSuffix: "explore_screen",
        ),
      ),
    );
  }
}
