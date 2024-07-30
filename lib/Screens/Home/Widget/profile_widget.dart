import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Theme/text_theme.dart';
import '../../Auth/Widget/form_field.dart';

class ProfileWidget extends StatelessWidget {
  final String title;
  final String? value;

  const ProfileWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextThemeStyle.textThemeStyle.bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.h),
        FormFieldWidget(
          hint: value ?? title,
          hintStyle: TextThemeStyle.textThemeStyle.bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
          readOnly: true,
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
