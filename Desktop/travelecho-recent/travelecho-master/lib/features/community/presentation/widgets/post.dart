import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/features/community/presentation/widgets/comment.dart';
import 'package:travelecho/features/community/presentation/widgets/share.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool _isLiked = false;
  bool _showComments = false;
  bool _wantsToShare = false;
  bool _userIsFollowing = false;

  final List<String> _comments = [
    "Amazing places!",
    "Wow! I love your travel stories.",
    "Where is this place?",
    "Looks like a dream destination!",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align to the edge
            children: [
              const CircleAvatar(
                radius: 30, // Reduced size of the image
                backgroundImage:
                    AssetImage('assets/images/community/profile_pic2.jpeg'),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Megan Kelly',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  // WidgetsSpacer.verticalSpacer8,
                  Text(
                    'Travelled 5 countries',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  // WidgetsSpacer.verticalSpacer8,
                  Text(
                    '5 d',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _userIsFollowing = !_userIsFollowing;
                  });
                },
                child: Text(
                  _userIsFollowing ? 'Following' : 'Follow',
                  style: TextStyle(
                      fontSize: FontSize.size16,
                      color: _userIsFollowing
                          ? AppColors.primaryColor300
                          : AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // WidgetsSpacer.verticalSpacer16,
              // Icon(Icons.add, color: Colors.purple, size: 20),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Two of my favorites, this is going to....',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Image.asset('assets/images/community/posted_img1.jpeg',
                    height: 150, fit: BoxFit.cover),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Image.asset('assets/images/community/posted_img2.jpeg',
                    height: 150, fit: BoxFit.cover),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isLiked = !_isLiked;
                  });
                },
                child: Column(
                  children: [
                    Icon(_isLiked ? Icons.favorite : LineIcons.heart,
                        color: _isLiked
                            ? AppColors.primaryColor
                            : AppColors.defaultColor400),
                    const Text('Like'),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showComments = !_showComments;
                        _wantsToShare = false;
                      });
                    },
                    child: Icon(LineIcons.comment,
                        color: AppColors.defaultColor400),
                  ),
                  const Text('Comment'),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showComments = false;
                    _wantsToShare = !_wantsToShare;
                  });
                },
                child: Column(
                  children: [
                    Icon(LineIcons.shareSquare,
                        color: AppColors.defaultColor400),
                    const Text('Share'),
                  ],
                ),
              ),
            ],
          ),
          if (_wantsToShare) const SharePost(),
          if (_showComments)
            Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      for (var comment in _comments)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              PostComment(
                                comment: comment,
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
