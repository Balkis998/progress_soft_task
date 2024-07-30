import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/Language/config.dart';
import 'package:flutter_task/Screens/Auth/login_screen.dart';
import 'package:flutter_task/Theme/app_colors.dart';

import '../../Language/change_lang.dart';
import '../../Language/key_lang.dart';
import '../../Style/assets.dart';
import '../../Theme/text_theme.dart';
import '../../Widgets/main_button.dart';

class LanguageScreen extends StatefulWidget {
  static const String id = 'LanguageScreen';
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  changeLanguage(BuildContext context, Locale local) {
    changeLang(context: context, local: local).then((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Dialog(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              child: Center(child: CircularProgressIndicator()));
        },
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.maybePop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.id, (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 66.h),
            Image.asset(ImageAssets.logo),
            SizedBox(height: 46.h),
            Text(KeyLang.selectLang.tr().toUpperCase(),
                style: TextThemeStyle.textThemeStyle.headlineSmall),
            SizedBox(height: 32.h),
            MainButton(
              width: double.infinity,
              color: AppColors.mainColor,
              isBordered: true,
              text: KeyLang.english.tr(),
              onPressed: () {
                changeLanguage(context, ConfigLanguage.enLocale);
              },
            ),
            SizedBox(height: 32.h),
            MainButton(
              width: double.infinity,
              color: AppColors.mainColor,
              isBordered: true,
              text: KeyLang.arabicLang.tr(),
              onPressed: () {
                changeLanguage(context, ConfigLanguage.arLocale);
              },
            ),
          ],
        ),
      ),
    );
  }
}
