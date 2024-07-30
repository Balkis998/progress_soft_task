import 'package:flutter/material.dart';

import '../Screens/Auth/login_screen.dart';
import '../Screens/Auth/register_screen.dart';
import '../Screens/Config/lang_screen.dart';
import '../Screens/Home/home_screen.dart';
import '../Screens/Profile/profile_screen.dart';
import '../Screens/Splash/splash_screen.dart';

class AppRoutes {
  Map<String, WidgetBuilder> routes = {
    LoginScreen.id: (context) => const LoginScreen(),
    HomeScreen.id: (context) => const HomeScreen(),
    ProfileScreen.id: (context) => const ProfileScreen(),
    RegisterScreen.id: (context) => const RegisterScreen(),
    LanguageScreen.id: (context) => const LanguageScreen(),
    SplashScreen.id: (context) => const SplashScreen(),
  };
}
