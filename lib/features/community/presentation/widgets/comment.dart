import 'package:flutter/material.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';

class PostComment extends StatelessWidget {
  final String comment;
  const PostComment({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 25,
            child: const CircleAvatar(
              radius: 25,
              backgroundImage:
                  AssetImage('assets/images/community/profile_pic3.jpeg'),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            children: [
              Text(
                "Sarah Noah",
                style: TextStyle(
                    fontSize: FontSize.size14, fontWeight: FontWeight.bold),
              ),
              Text(
                "#STS678923",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      Text(
        comment,
        style: TextStyle(fontSize: FontSize.size14),
      )
    ]));
  }
}
