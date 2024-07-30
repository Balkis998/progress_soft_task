import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Model/post_model.dart';
import '../../Theme/app_colors.dart';
import '../../Theme/text_theme.dart';

class PostScreen extends StatelessWidget {
  final PostModel post;
  final String? image;
  const PostScreen({super.key, required this.post, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        children: [
          if (image != null) Image.asset(image!),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: TextThemeStyle.textThemeStyle.bodyLarge,
                ),
                SizedBox(height: 16.h),
                Text(
                  post.body,
                  style: TextThemeStyle.textThemeStyle.bodyMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
