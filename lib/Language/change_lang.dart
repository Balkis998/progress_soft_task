// ignore_for_file: use_build_context_synchronously

// import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/global.dart';
import 'config.dart';

Locale local = ConfigLanguage.localLang ?? ConfigLanguage.enLocale;

Future<void> changeLang(
    {required BuildContext context, required Locale local}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (local == ConfigLanguage.enLocale) {
    local = ConfigLanguage.enLocale;
    lang = 'en';
  } else {
    local = ConfigLanguage.arLocale;
    lang = 'ar';
  }

  context.setLocale(local);
  await prefs.setString('lang', local.toString());
}
