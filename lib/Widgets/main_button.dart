import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Theme/app_colors.dart';
import '../../Theme/text_theme.dart';

class MainButton extends StatelessWidget {
  final String text;
  final bool isBordered;
  final bool isGradiunt;
  final VoidCallback onPressed;
  final Widget? icon;
  final double? radius;
  final Color? color;
  final List<Color>? gradiuntColors;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final bool isDisabled;
  final Widget? widgetButton;
  final List<BoxShadow>? boxShadow;
  const MainButton({
    super.key,
    this.isBordered = false,
    required this.text,
    required this.onPressed,
    this.radius,
    this.color,
    this.icon,
    this.isGradiunt = false,
    this.textStyle,
    this.gradiuntColors,
    this.width,
    this.height,
    this.isDisabled = false,
    this.widgetButton,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final appColor = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        height: height ?? 52.h,
        width: width ?? 160.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(radius ?? 10),
            ),
            boxShadow: isDisabled ? [] : boxShadow,
            border: isBordered
                ? Border.all(
                    color: isBordered && isDisabled
                        ? AppColors.borderColor
                        : color ?? appColor.primary,
                    width: 2.w)
                : isDisabled
                    ? Border.all(color: Colors.transparent)
                    : null,
            color: isBordered
                ? AppColors.white
                : isDisabled
                    ? AppColors.mainColor.withOpacity(0.7)
                    : color ?? AppColors.mainColor,
            gradient: isGradiunt == true
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradiuntColors!,
                    stops: const [0.0, 1.0], // Gradient stops
                  )
                : null),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Center(
              child: widgetButton ??
                  Text(
                    text,
                    style: textStyle ??
                        TextThemeStyle.textThemeStyle.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isBordered
                              ? isBordered && isDisabled
                                  ? AppColors.borderColor
                                  : color ?? appColor.primary
                              : AppColors.white,
                        ),
                  ),
            )),
      ),
    );
  }
}
