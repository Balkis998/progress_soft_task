import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Language/change_lang.dart';
import '../Language/config.dart';
import '../Language/key_lang.dart';
import '../Theme/text_theme.dart';

class DefaultAppbar extends StatelessWidget {
  final void Function()? onPressed;
  const DefaultAppbar({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        TextButton(
            onPressed: onPressed,
            child: Text(
              local == ConfigLanguage.arLocale
                  ? KeyLang.arabicLang.tr()
                  : KeyLang.english.tr(),
              style: TextThemeStyle.textThemeStyle.bodyLarge!
                  .copyWith(color: Colors.white),
            )),
      ],
    );
  }
}
