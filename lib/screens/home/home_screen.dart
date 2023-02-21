import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_app/models/genre.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:grocery_app/screens/home/search_delegate.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/services/books_services.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';
import 'package:grocery_app/widgets/custom_carousel.dart';
import 'package:grocery_app/widgets/home_categories.dart';
import 'package:grocery_app/widgets/loader.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BooksService booksService = BooksService();
  late Completer<List<Genre>> _genresCompleter;
  List<Genre> genreList = [];

  @override
  void initState() {
    super.initState();
    _genresCompleter = Completer<List<Genre>>();
    getGenres();
  }

  // getGenres() async {
  //   if (mounted) {
  //     genreList = await booksService.fetchGenres(context);
  //     setState(() {});
  //   }
  // }
  getGenres() async {
    if (!_genresCompleter.isCompleted) {
      try {
        List<Genre> genres = await booksService.fetchGenres(context);
        if (!_genresCompleter.isCompleted) {
          _genresCompleter.complete(genres);
        }
      } catch (e) {
        if (!_genresCompleter.isCompleted) {
          _genresCompleter.completeError(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().account;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  SvgPicture.asset("assets/icons/app_icon_color.svg"),
                  SizedBox(
                    height: 5,
                  ),
                  padded(locationWidget(user.name)),
                  SizedBox(
                    height: 15,
                  ),
                  padded(
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(color: AppColors.lightGrey, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                      leading: Icon(Icons.search),
                      contentPadding: const EdgeInsets.only(
                        left: 30,
                      ),
                      title: const Text(
                        'Search for your books',
                      ),
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: SearchBookDelegate(),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // CarouselWidget(
                  //   images: [
                  //     'assets/images/carousel1.jpg',
                  //     'assets/images/carousel2.jpg',
                  //     'assets/images/carousel3.jpg',
                  //     'assets/images/carousel4.jpg',
                  //     'assets/images/carousel5.jpg',
                  //   ],
                  // ),

                  FutureBuilder(
                    future: _genresCompleter.future,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 200,
                          child: CategoryGridView(
                            icons: [
                              'assets/icons/genre_icons/genre20.svg',
                              'assets/icons/genre_icons/genre28.svg',
                              'assets/icons/genre_icons/genre22.svg',
                              'assets/icons/genre_icons/genre30.svg',
                              'assets/icons/genre_icons/genre12.svg',
                              'assets/icons/genre_icons/genre13.svg',
                              'assets/icons/genre_icons/genre8.svg',
                            ],
                            genres: snapshot.data!,
                          ),
                        );
                      } else {
                        return SizedBox(height: 200, child: const Loader());
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  padded(subTitle("Chủ Đề Hấp Dẫn")),
                  getHorizontalItemSlider(exclusiveOffers),
                  SizedBox(
                    height: 15,
                  ),
                  padded(subTitle("Bán Chạy")),
                  getHorizontalItemSlider(bestSelling),
                  SizedBox(
                    height: 15,
                  ),
                  padded(subTitle("Sách Mới")),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Container(
                  //   height: 105,
                  //   child: ListView(
                  //     padding: EdgeInsets.zero,
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       GroceryFeaturedCard(
                  //         groceryFeaturedItems[0],
                  //         color: Color(0xffF8A44C),
                  //       ),
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       GroceryFeaturedCard(
                  //         groceryFeaturedItems[1],
                  //         color: AppColors.primaryColor,
                  //       ),
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  getHorizontalItemSlider(groceries),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget getHorizontalItemSlider(List<GroceryItem> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 250,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 8),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onItemClicked(context, items[index]);
            },
            child: GroceryItemCardWidget(
              item: items[index],
              heroSuffix: "home_screen",
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 8,
          );
        },
      ),
    );
  }

  void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
                groceryItem,
                heroSuffix: "home_screen",
              )),
    );
  }

  Widget subTitle(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          "Xem thêm",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
      ],
    );
  }

  Widget locationWidget(String address) {
    String locationIconPath = "assets/icons/location_icon.svg";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          locationIconPath,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          address,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
