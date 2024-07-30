import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Theme/app_colors.dart';
import '../../../Theme/text_theme.dart';

class TextButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String text1;
  final String text2;
  final Color? disableColor;

  const TextButtonWidget(
      {super.key,
      this.onPressed,
      required this.text1,
      required this.text2,
      this.disableColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text1,
              style: TextThemeStyle.textThemeStyle.bodyMedium!.copyWith(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w400)),
          SizedBox(
            width: 5.w,
          ),
          Text(
            text2,
            style: TextThemeStyle.textThemeStyle.bodyMedium!.copyWith(
                color: disableColor ?? AppColors.mainColor,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
