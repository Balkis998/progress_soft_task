// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../Language/key_lang.dart';
import '../../../Theme/app_colors.dart';
import '../../../Theme/text_theme.dart';
import '../register_screen.dart';

class NotRegisterDialog extends StatelessWidget {
  final String? title;

  final BuildContext c;

  const NotRegisterDialog(
    this.c, {
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              backgroundColor: Colors.white,
              title: Text(KeyLang.userNotRegistered.tr()),
              content: Text(KeyLang.userNotRegisteredMessage.tr()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    KeyLang.cancel.tr(),
                    style: TextThemeStyle.textThemeStyle.bodyLarge!
                        .copyWith(color: AppColors.blackColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, RegisterScreen.id);
                  },
                  child: Text(
                    KeyLang.register.tr(),
                    style: TextThemeStyle.textThemeStyle.bodyLarge,
                  ),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
          ],
        ));
  }
}
