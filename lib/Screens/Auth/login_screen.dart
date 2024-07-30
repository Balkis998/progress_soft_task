import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../BloC/Auth/Login/login_bloc.dart';
import '../../Language/key_lang.dart';
import '../../Style/assets.dart';
import '../../Theme/text_theme.dart';
import 'Widget/login_form.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocProvider(
          create: (context) => LoginCubit(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 46.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(ImageAssets.logo),
                SizedBox(height: 30.h),
                Text(KeyLang.login.tr().toUpperCase(),
                    style: TextThemeStyle.textThemeStyle.headlineSmall),
                SizedBox(height: 12.h),
                const LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
