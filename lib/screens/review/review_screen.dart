import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grocery_app/common_widgets/app_textfield.dart';
import 'package:grocery_app/screens/review/widgets/comment_items.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:intl/intl.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: AppColors.lightGrey,
                ),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.add_comment_outlined,
                    size: 30,
                  ),
                  OutlinedButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Rate the product'),
                              content: Container(
                                height: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RatingBar.builder(
                                      itemSize: 30,
                                      initialRating: 4,
                                      minRating: 0.5,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: AppColors.secondaryColor,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Expanded(
                                      child: AppTextField(
                                        controller: commentController,
                                        isObscure: false,
                                        maxLines: 5,
                                        hintText: '',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(
                                      context), // Closes the dialog
                                  child: Text('No'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Changes the tab

                                    Navigator.pop(context); // Closes the dialog
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            )),
                    child: const Text('Comment'),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return CommentWidget(
                    rating: 3,
                    comment:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam at libero et elit pretium tincidunt sit amet sit amet est. Proin aliquet, leo a luctus suscipit, velit felis vehicula eros, sit amet rhoncus ipsum eros eget ex. Nullam sed purus vel ante facilisis dapibus eu vel sem. Nam nec nisi vitae lorem consectetur pellentesque. Sed aliquam sapien vel tellus blandit, eu facilisis ex consectetur. Maecenas malesuada ligula vel urna commodo, ut sollicitudin tellus sagittis. Etiam bibendum mauris ac eros hendrerit, at cursus mauris volutpat. Morbi tincidunt ipsum et leo ullamcorper vulputate. Ut varius elit at velit faucibus tincidunt. Nullam viverra, sapien vel rutrum bibendum, nunc ante mattis orci, ac suscipit nisi tortor sit amet libero. Sed convallis malesuada ligula ac malesuada. Duis auctor finibus eros, nec tincidunt enim pellentesque ac. Nulla non ligula quis felis tincidunt ultricies. Donec malesuada ante quis nulla convallis, sit amet laoreet dolor lobortis.',
                    date: DateFormat('dd/MM/y h:mm a').format(DateTime.now()),
                    name: 'Khoa Bui',
                  );
                }),
          )
        ],
      ),
    );
  }
}
