// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../BloC/Auth/Login/login_bloc.dart';
import '../../../BloC/Auth/Register/register_cubit.dart';
import '../../../Language/key_lang.dart';
import '../../../Theme/app_colors.dart';
import '../../../Theme/text_theme.dart';
import '../../../Widgets/main_button.dart';
import '../../Home/home_screen.dart';

class OtpForm extends StatefulWidget {
  final String? phone;
  final String? verificationId;
  final bool isLogin;
  const OtpForm(
      {super.key, this.phone, this.verificationId, required this.isLogin});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  String otp = '';

  @override
  void initState() {
    super.initState();
    startTimer(reset: false);
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
        stopTimer(reset: false);
      }
    });
  }

  void resetTimer() => setState(() {
        seconds = maxSeconds;
        enableResend = false;
      });

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer?.cancel();
  }

  bool enableResend = false;
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        OtpPinField(
            key: _otpPinFieldController,
            autoFillEnable: true,
            textInputAction: TextInputAction.done,
            onSubmit: (text) {
              setState(() {
                otp = text;
              });
            },
            onChange: (text) {
              setState(() {
                otp = text;
              });
            },
            keyboardType: TextInputType.number,
            otpPinFieldStyle: OtpPinFieldStyle(
              defaultFieldBorderColor: AppColors.borderColor,
              activeFieldBorderColor: AppColors.borderColor,
              defaultFieldBackgroundColor: Colors.transparent,
              activeFieldBackgroundColor: Colors.transparent,
              filledFieldBackgroundColor: Colors.transparent,
              filledFieldBorderColor: Colors.transparent,
              textStyle: TextThemeStyle.textThemeStyle.bodyLarge!
                  .copyWith(color: AppColors.mainColor),
            ),
            maxLength: 6,
            showCursor: true,
            cursorColor: Colors.black,
            showCustomKeyboard: false,
            showDefaultKeyboard: true,
            cursorWidth: 1,
            fieldWidth: 40.w,
            otpPinFieldDecoration:
                OtpPinFieldDecoration.defaultPinBoxDecoration),
        Divider(
          color: AppColors.formBorderColor,
          height: 30.h,
        ),
        SizedBox(height: 30.h),
        MainButton(
          text: KeyLang.confirmCode.tr(),
          width: double.infinity,
          color: AppColors.mainColor,
          isDisabled: otp.length != 6,
          radius: 10.r,
          onPressed: () async {
            if (otp.length == 6) {
              if (widget.isLogin == true) {
                print('he');
                UserCredential? userCredential =
                    await context.read<LoginCubit>().verifyOTP(
                          smsCode: otp,
                          verificationId: widget.verificationId ?? '',
                        );

                print('userCredential == $userCredential');

                if (userCredential != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.id, (route) => false);
                }
              } else {
                UserCredential? userCredential =
                    await context.read<RegisterCubit>().verifyOTP(
                          smsCode: otp,
                          phone: widget.phone ?? '',
                          verificationId: widget.verificationId ?? '',
                        );

                if (userCredential != null) {
                  return Navigator.pop(context, userCredential);
                }
              }
            }
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        if (enableResend == true)
          TextButton(
            onPressed: () async {
              startTimer();
              try {
                if (widget.isLogin) {
                  await context.read<LoginCubit>().sendCodePressed();
                } else {
                  context
                      .read<RegisterCubit>()
                      .verifyPhoneNumber(widget.phone ?? '');
                }
              } catch (e) {
                // Handle error (Failed to resend code)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to resend code')),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  KeyLang.didntRecieve.tr(),
                  style: const TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  KeyLang.resend.tr(),
                  style: TextThemeStyle.textThemeStyle.bodyLarge!.copyWith(
                      color: AppColors.mainColor,
                      decoration: TextDecoration.underline),
                )
              ],
            ),
          ),
        SizedBox(height: 8.h),
        buildTimer(),
      ],
    );
  }

  Widget buildTimer() => SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: seconds / (60),
              valueColor: AlwaysStoppedAnimation(AppColors.mainColor),
              strokeWidth: 5,
              backgroundColor: AppColors.secondaryColor,
            ),
            Center(
              child: buildTime(),
            ),
          ],
        ),
      );

  Widget buildTime() {
    return Text(
      '$seconds',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
          color: AppColors.mainColor),
    );
  }
}
