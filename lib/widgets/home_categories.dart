import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/models/genre.dart';

class CategoryGridView extends StatelessWidget {
  final List<String> icons;
  final List<Genre> genres;
  const CategoryGridView(
      {super.key, required this.icons, required this.genres});
  void navigateToCategoryScreen(BuildContext context, Genre genre) {
    Navigator.pushNamed(
      context,
      RoutesHandler.CATEGORY_PRODUCTS,
      arguments: genre,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          scrollDirection: Axis.horizontal,
          itemCount: genres.length >= 8 ? 8 : genres.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => navigateToCategoryScreen(context, genres[index]),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      child: SvgPicture.asset(icons[index]),
                      // decoration: BoxDecoration(
                      //   shape: BoxShape.rectangle,
                      //   image: DecorationImage(
                      //     image: AssetImage(icons[index]),
                      //     fit: BoxFit.cover,
                      //   ),
                      //   borderRadius: const BorderRadius.all(Radius.circular(5)),
                      // ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      genres[index].genreName,
                      style: const TextStyle(fontSize: 9),
                    ),
                  ],
                ),
              ),
            );

            // List.generate(
            //   10,
            //   (index) {
            //     String category = '';
            //     switch (index) {
            //       case 0:
            //         category = "Viễn tưởng";
            //         break;
            //       case 1:
            //         category = "Cổ tích";
            //         break;
            //       case 2:
            //         category = "Giật gân";
            //         break;
            //       case 3:
            //         category = "Tình cảm";
            //         break;
            //       case 4:
            //         category = "Tâm lý";
            //         break;
            //       case 5:
            //         category = "Nghệ thuật";
            //         break;
            //       case 6:
            //         category = "Khoa học";
            //         break;
            //       case 7:
            //         category = "Lịch sử";
            //         break;
            //       case 8:
            //         category = "Kinh dị";
            //         break;
            //       case 9:
            //         category = "Phiêu lưu";
            //         break;
            //     }
            // return InkWell(
            //   onTap: () {},
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: Colors.transparent,
            //     ),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Container(
            //           height: 40,
            //           width: 40,
            //           child: SvgPicture.asset(icons[index]),
            //           // decoration: BoxDecoration(
            //           //   shape: BoxShape.rectangle,
            //           //   image: DecorationImage(
            //           //     image: AssetImage(icons[index]),
            //           //     fit: BoxFit.cover,
            //           //   ),
            //           //   borderRadius: const BorderRadius.all(Radius.circular(5)),
            //           // ),
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           category,
            //           style: const TextStyle(fontSize: 9),
            //         ),
            //       ],
            //     ),
            //   ),
            // );
            //   },
            // ),
          }),
    );
  }
}
