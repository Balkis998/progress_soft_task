import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'BloC/Config/config.dart';
import 'BloC/Config/config_bloc.dart';
import 'Routers/router.dart';
import 'Screens/Splash/splash_screen.dart';
import 'Theme/custom_theme.dart';

class MyApp extends StatelessWidget {
  final ConfigRepository configRepository;

  const MyApp({super.key, required this.configRepository});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 813),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext c, child) {
          return BlocProvider(
            create: (context) => ConfigCubit(configRepository),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Task',
              theme: CustomTheme.lightTheme(context),
              themeMode: ThemeMode.light,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routes: AppRoutes().routes,
              initialRoute: SplashScreen.id,
            ),
          );
        });
  }
}
