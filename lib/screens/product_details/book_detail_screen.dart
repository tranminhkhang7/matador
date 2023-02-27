import 'package:flutter/material.dart';

import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/common_widgets/stars.dart';

import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/providers/favorite_list_provider.dart';
import 'package:grocery_app/services/cart_services.dart';

import 'package:grocery_app/widgets/book_item_card_widget.dart';

import 'package:grocery_app/widgets/item_counter_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'favourite_toggle_icon_widget.dart';

class BookDetailScreen extends StatefulWidget {
  final BookItem bookItem;
  final String? heroSuffix;
  const BookDetailScreen({
    Key? key,
    required this.bookItem,
    this.heroSuffix,
  }) : super(key: key);

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  List<BookItem> mockList = [
    BookItem(
      bookId: 1,
      author: 'Khoa',
      description: 'Khoa',
      imageLink:
          'https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      price: 2,
      publisher: 'Khoa',
      quantityLeft: 15,
      status: 'active',
      title: 'Book test',
    ),
    BookItem(
      bookId: 2,
      author: 'Khoa',
      description: 'Khoa',
      imageLink:
          'https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      price: 2,
      publisher: 'Khoa',
      quantityLeft: 15,
      status: 'active',
      title: 'Book test',
    ),
    BookItem(
      bookId: 3,
      author: 'Khoa',
      description: 'Khoa',
      imageLink:
          'https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      price: 2,
      publisher: 'Khoa',
      quantityLeft: 15,
      status: 'active',
      title: 'Book test',
    ),
    BookItem(
      bookId: 4,
      author: 'Khoa',
      description: 'Khoa',
      imageLink:
          'https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      price: 2,
      publisher: 'Khoa',
      quantityLeft: 15,
      status: 'active',
      title: 'Book test',
    ),
    BookItem(
      bookId: 5,
      author: 'Khoa',
      description: 'Khoa',
      imageLink:
          'https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      price: 2,
      publisher: 'Khoa',
      quantityLeft: 15,
      status: 'active',
      title: 'Book test',
    ),
  ];

  int amount = 1;
  // List<BookItem> mockList = bookItemList;
  bool _isLoading = false;
  final CartServices cartServices = CartServices();
  @override
  void initState() {
    super.initState();
  }

  void navigateToReviewScreen() {
    Navigator.pushNamed(
      context,
      RoutesHandler.COMMENT,
    );
  }

  void addToCart(int bookId, int quantity) async {
    setState(() {
      _isLoading = true;
    });
    await cartServices.addToCart(context, bookId, quantity);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavoriteListProvider>().favoriteList;
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
            padding: const EdgeInsets.only(left: 25),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: AppText(
            text: widget.bookItem.title,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              getImageHeaderWidget(),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        '${widget.bookItem.title} - ${widget.bookItem.author}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: AppText(
                          text: widget.bookItem.description,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff7C7C7C),
                          maxLines: 5,
                        ),
                      ),
                      trailing: FavoriteToggleIcon(
                        id: widget.bookItem.bookId,
                        isFavorite: favProvider.contains(widget.bookItem),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ItemCounterWidget(
                          onAmountChanged: (newAmount) {
                            setState(() {
                              amount = newAmount;
                            });
                          },
                          quantity: amount,
                          quantityLeft: int.parse(
                              widget.bookItem.quantityLeft.toString()),
                        ),
                        Column(
                          children: [
                            Text(
                              "\$${getTotalPrice().toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('${widget.bookItem.quantityLeft} left'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    getHorizontalItemSlider(mockList),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(thickness: 1),
                    getProductDataRowWidget("Product Details"),
                    Divider(thickness: 1),
                    GestureDetector(
                      onTap: () => navigateToReviewScreen(),
                      child: getProductDataRowWidget(
                        "Review",
                        customWidget: ratingWidget(),
                      ),
                    ),
                    Divider(thickness: 1),
                    const SizedBox(
                      height: 15,
                    ),
                    AppButton(
                      label: "Add To Basket",
                      onPressed: () =>
                          addToCart(widget.bookItem.bookId, amount),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigateToBookDetailScreen(BookItem b) {
    Navigator.pushNamed(
      context,
      RoutesHandler.SINGLE_PRODUCT,
      arguments: b,
    );
  }

  Widget getHorizontalItemSlider(List<BookItem> items) {
    return Container(
      height: 200,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToBookDetailScreen(items[index]),
            child: BookItemCardWidget(
              item: items[index],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20,
          );
        },
      ),
    );
  }

  Widget getImageHeaderWidget() {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF).withOpacity(0.1),
              const Color(0xFF3366FF).withOpacity(0.09),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Hero(
        tag: "GroceryItem:" +
            widget.bookItem.title +
            "-" +
            (widget.heroSuffix ?? ""),
        child: Image(
          image: NetworkImage(widget.bookItem.imageLink),
        ),
      ),
    );
  }

  Widget getProductDataRowWidget(String label, {Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          AppText(text: label, fontWeight: FontWeight.w600, fontSize: 16),
          Spacer(),
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            )
          ],
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
          )
        ],
      ),
    );
  }

  Widget ratingWidget() {
    Widget starIcon() {
      return Icon(
        Icons.star,
        color: Color(0xffF3603F),
        size: 20,
      );
    }

    return Stars(
      rating: 4.5,
    );
  }

  double getTotalPrice() {
    return amount * widget.bookItem.price;
  }
}
