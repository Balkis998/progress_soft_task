import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../BloC/Home/post_bloc.dart';
import '../../BloC/Profile/profile_cubit.dart';
import '../../Language/key_lang.dart';
import 'Widget/home_tab.dart';
import 'Widget/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    const HomeTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PostBloc()),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(KeyLang.title.tr()),
        ),
        body: _tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: KeyLang.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.person,
              ),
              label: KeyLang.profile.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
