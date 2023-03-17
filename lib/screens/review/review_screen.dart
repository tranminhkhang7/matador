import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import 'package:grocery_app/common_widgets/app_textfield.dart';
import 'package:grocery_app/screens/review/widgets/comment_items.dart';
import 'package:grocery_app/styles/colors.dart';

import '../../models/comment.dart';

class ReviewScreen extends StatefulWidget {
  final List<Comment>? comments;
  const ReviewScreen({
    Key? key,
    this.comments,
  }) : super(key: key);

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
            child: widget.comments == null
                ? SizedBox()
                : ListView.builder(
                    itemCount: widget.comments?.length,
                    itemBuilder: (context, index) {
                      return CommentWidget(
                        rating: widget.comments![index].rating,
                        comment: widget.comments![index].content,
                        date: DateFormat('dd/MM/y h:mm a')
                            .format(widget.comments![index].timestamp),
                        name: 'Khoa Bui',
                      );
                    }),
          )
        ],
      ),
    );
  }
}
