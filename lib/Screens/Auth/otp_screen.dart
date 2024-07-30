import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../BloC/Auth/Login/login_bloc.dart';
import '../../BloC/Auth/Register/register_cubit.dart';
import '../../Language/key_lang.dart';
import '../../Style/assets.dart';
import '../../Theme/text_theme.dart';
import 'Widget/otp_form.dart';

class OTPScreen extends StatelessWidget {
  final String? phone;
  final String? verificationId;
  final bool isLogin;

  const OTPScreen(
      {super.key, this.phone, this.verificationId, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => RegisterCubit()),
            BlocProvider(create: (context) => LoginCubit()),
          ],
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
                Text(KeyLang.verify.tr().toUpperCase(),
                    style: TextThemeStyle.textThemeStyle.headlineSmall),
                SizedBox(height: 12.h),
                OtpForm(
                    phone: phone,
                    verificationId: verificationId,
                    isLogin: isLogin)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
