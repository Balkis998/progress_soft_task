import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'text_theme.dart';

/// Doc : https://api.flutter.dev/flutter/material/TextTheme-class.html
class CustomTheme {
  // * * * * * * * * * * * * *** Light *** * * * * * * * * * * * *
  static ThemeData lightTheme(BuildContext context) {
    TextThemeStyle.setTextTheme(context);
    return ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: AppColors.mainColor,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: AppColors.white,
            fontSize: 20.sp,
            fontFamily: 'Cairo',
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              color: AppColors.blackColor,
              fontSize: 20.sp,
              fontFamily: 'Cairo',
            ),
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.mainColor),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.mainColor,
              displayColor: Colors.black,
              fontFamily: 'Cairo',
            ),
        dividerColor: const Color(0xFFD9D9D9));
  }
}
