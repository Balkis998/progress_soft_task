import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_task/Screens/Home/home_screen.dart';
import 'package:flutter_task/Style/assets.dart';

import '../../BloC/Config/config_bloc.dart';
import '../../BloC/Config/config_state.dart';
import '../../Theme/text_theme.dart';
import '../Config/lang_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getToken();
    context.read<ConfigCubit>().loadConfig();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(context,
          token == null ? LanguageScreen.id : HomeScreen.id, (route) => false);
    });
  }

  String? token;

  getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    token = await secureStorage.read(key: 'user_token');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(ImageAssets.logo),
                const SizedBox(height: 20),
                Text(
                  'Copyright © 2024 ProgressSoft Corporation. All Rights Reserved',
                  style: TextThemeStyle.textThemeStyle.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
