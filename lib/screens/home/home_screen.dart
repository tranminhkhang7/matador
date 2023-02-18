import 'package:flutter/material.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';
import 'package:grocery_app/widgets/search_bar_widget.dart';

import 'grocery_featured_Item_widget.dart';
import 'package:grocery_app/widgets/custom_carousel.dart';
import 'package:grocery_app/widgets/home_categories.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  padded(locationWidget()),
                  SizedBox(
                    height: 15,
                  ),
                  padded(SearchBarWidget()),
                  SizedBox(
                    height: 25,
                  ),
                  CarouselWidget(
                    images: [
                      'assets/images/carousel1.jpg',
                      'assets/images/carousel2.jpg',
                      'assets/images/carousel3.jpg',
                      'assets/images/carousel4.jpg',
                      'assets/images/carousel5.jpg',
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: CategoryGridView(
                      icons: [
                        'assets/icons/genre20.jpg',
                        'assets/icons/genre28.jpg',
                        'assets/icons/genre22.jpg',
                        'assets/icons/genre30.jpg',
                        'assets/icons/genre12.jpg',
                        'assets/icons/genre13.jpg',
                        'assets/icons/genre8.jpg',
                        'assets/icons/genre21.jpg',
                        'assets/icons/genre26.jpg',
                        'assets/icons/genre17.jpg',
                      ],
                    ),
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

  Widget locationWidget() {
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
          "Khartoum,Sudan",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
