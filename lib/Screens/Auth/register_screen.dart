import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../BloC/Auth/Register/register_cubit.dart';
import '../../Language/key_lang.dart';
import '../../Style/assets.dart';
import '../../Theme/text_theme.dart';
import 'Widget/register_form.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'RegisterScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocProvider(
          create: (context) => RegisterCubit(),
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
                Text(KeyLang.register.tr().toUpperCase(),
                    style: TextThemeStyle.textThemeStyle.headlineSmall),
                SizedBox(height: 12.h),
                const RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
