import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final double rating;
  final String name;
  final String date;
  final String comment;

  CommentWidget(
      {required this.rating,
      required this.name,
      required this.date,
      required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                rating.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.star,
                size: 18,
                color: Colors.yellow[700],
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            comment,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
