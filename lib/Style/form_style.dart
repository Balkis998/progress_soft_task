import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/app_colors.dart';
import '../Theme/text_theme.dart';

class AppStyles {
  static InputDecoration formStyle(String hint,
      {Widget? suffixIcon,
      Widget? suffix,
      Widget? prefixIcon,
      double? radius,
      Color? filledColor,
      Color? borderColor,
      Color? focusBorderColor,
      TextStyle? hintStyle,
      Color? errorBorderColor,
      Widget? label,
      String? labelText,
      BuildContext? context,
      EdgeInsetsGeometry? contentPadding,
      Color? enabledBorderColor}) {
    return InputDecoration(
      label: label,
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: enabledBorderColor ?? AppColors.borderColor),
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.r)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: focusBorderColor ?? AppColors.borderColor),
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.r)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? AppColors.borderColor),
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.r)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: errorBorderColor ?? AppColors.errorColor, width: 2.w),
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.r)),
      ),
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      fillColor: filledColor ?? AppColors.formFillColor,
      suffixIcon: suffixIcon,
      suffix: suffix,
      labelText: labelText,
      labelStyle: TextThemeStyle.textThemeStyle.bodyMedium!
          .copyWith(color: AppColors.mainColor),
      prefixIcon: prefixIcon,
      filled: true,
      hintStyle: hintStyle ??
          TextThemeStyle.textThemeStyle.bodyMedium!
              .copyWith(color: AppColors.hintColor),
      hintText: hint,
    );
  }
}
