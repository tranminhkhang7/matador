import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/book_item.dart';

import 'package:grocery_app/styles/colors.dart';

class BookItemCardWidget extends StatelessWidget {
  BookItemCardWidget({Key? key, required this.item, this.heroSuffix})
      : super(key: key);
  final BookItem item;
  final String? heroSuffix;

  final double width = 224;
  final double height = 300;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: "BookItem: ${generateRandomString(5)}" +
                      item.bookId.toString() +
                      "-" +
                      (heroSuffix ?? ""),
                  child: imageWidget(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              text: item.title,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
            // AppText(
            //   text: item.description,
            //   fontSize: 14,
            //   fontWeight: FontWeight.w600,
            //   color: Color(0xFF7C7C7C),
            //   maxLines: 1,
            //   textOverflow: TextOverflow.ellipsis,
            // ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                AppText(
                  text: "\$${item.price.toStringAsFixed(2)}",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
                addWidget()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      height: 200,
      child: Image.network(
        item.imageLink,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget addWidget() {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: AppColors.primaryColor),
      child: Center(
        child: InkWell(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
    );
  }
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: borderColor,
//         ),
//         borderRadius: BorderRadius.circular(
//           borderRadius,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 15,
//           vertical: 15,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Center(
//                 child: Hero(
//                   tag: "BookItem: ${generateRandomString(5)}" +
//                       item.bookId.toString() +
//                       "-" +
//                       (heroSuffix ?? ""),
//                   child: imageWidget(),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             AppText(
//               text: item.title,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               maxLines: 1,
//               textOverflow: TextOverflow.ellipsis,
//             ),
//             AppText(
//               text: item.description,
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF7C7C7C),
//               maxLines: 1,
//               textOverflow: TextOverflow.ellipsis,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 AppText(
//                   text: "\$${item.price.toStringAsFixed(2)}",
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 Spacer(),
//                 addWidget()
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget imageWidget() {
//     return Container(
//       child: Image.network(
//         item.imageLink,
//         fit: BoxFit.fitHeight,
//       ),
//     );
//   }

//   Widget addWidget() {
//     return Container(
//       height: 45,
//       width: 45,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(17),
//           color: AppColors.primaryColor),
//       child: Center(
//         child: InkWell(
//           child: Icon(
//             Icons.add,
//             color: Colors.white,
//             size: 25,
//           ),
//         ),
//       ),
//     );
//   }
}
