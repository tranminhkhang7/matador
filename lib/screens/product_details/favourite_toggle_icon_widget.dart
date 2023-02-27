import 'package:flutter/material.dart';
import 'package:grocery_app/services/books_services.dart';

class FavoriteToggleIcon extends StatefulWidget {
  final int id;
  final bool isFavorite;
  const FavoriteToggleIcon(
      {super.key, required this.id, required this.isFavorite});
  @override
  _FavoriteToggleIconState createState() => _FavoriteToggleIconState();
}

class _FavoriteToggleIconState extends State<FavoriteToggleIcon> {
  late bool favorite;

  BooksService booksService = BooksService();
  @override
  void initState() {
    favorite = widget.isFavorite;
    super.initState();
  }

  void addToFavorite(int id) async {
    await booksService.addToFavorite(context, id);
  }

  void removeFromFavorite(int id) {
    booksService.deleteFromFavorite(context, id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        favorite == false
            ? addToFavorite(widget.id)
            : removeFromFavorite(widget.id);
        setState(() {
          favorite = !favorite;
        });
      },
      child: Icon(
        favorite ? Icons.favorite : Icons.favorite_border,
        color: favorite ? Colors.red : Colors.blueGrey,
        size: 30,
      ),
    );
  }
}
