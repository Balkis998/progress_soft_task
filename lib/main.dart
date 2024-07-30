import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BloC/Config/config.dart';
import 'Language/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? lang = prefs.getString('lang');
  Locale initialLocale = ConfigLanguage.enLocale; // default locale

  if (lang != null) {
    initialLocale =
        lang == 'ar' ? ConfigLanguage.arLocale : ConfigLanguage.enLocale;
  }

  final configRepository = ConfigRepository();

  runApp(EasyLocalization(
      supportedLocales: const [
        ConfigLanguage.arLocale,
        ConfigLanguage.enLocale
      ],
      startLocale: initialLocale,
      path: ConfigLanguage.langPath,
      fallbackLocale: ConfigLanguage.enLocale,
      child: MyApp(configRepository: configRepository)));
}
