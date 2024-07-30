import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/Language/change_lang.dart';
import 'package:flutter_task/Language/config.dart';
import 'package:flutter_task/Style/assets.dart';
import 'package:flutter_task/Widgets/main_button.dart';

import '../../../BloC/Profile/profile_cubit.dart';
import '../../../Language/key_lang.dart';
import '../../../Theme/text_theme.dart';
import '../../Auth/login_screen.dart';
import 'profile_widget.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchUserData();
  }

  _handleLogout() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    await secureStorage.delete(
        key: 'user_token'); // delete user token from secure storage
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileError) {
          return Text('Error: ${state.message}');
        } else if (state is ProfileLoaded) {
          var userData = state.userData;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        userData['gender'] == 'male'
                            ? ImageAssets.person1
                            : ImageAssets.person2,
                        fit: BoxFit.cover,
                        width: 50.w,
                        height: 50.h,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      KeyLang.personalInfo.tr(),
                      style: TextThemeStyle.textThemeStyle.titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ProfileWidget(
                  title: KeyLang.fullName.tr(),
                  value: userData['fullName'],
                ),
                ProfileWidget(
                  title: KeyLang.phone.tr(),
                  value: userData['phone'],
                ),
                ProfileWidget(
                  title: KeyLang.gender.tr(),
                  value: userData['gender'],
                ),
                ProfileWidget(
                  title: KeyLang.age.tr(),
                  value: userData['age'],
                ),
                const Spacer(),
                SizedBox(height: 16.h),
                MainButton(
                  text: '',
                  width: double.infinity,
                  widgetButton: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        KeyLang.logout.tr(),
                        style: TextThemeStyle.textThemeStyle.titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                      ),
                      SizedBox(width: 8.w),
                      SvgPicture.asset(local == ConfigLanguage.arLocale
                          ? SvgAssets.logoutAr
                          : SvgAssets.logout),
                    ],
                  ),
                  onPressed: _handleLogout,
                ),
              ],
            ),
          );
        }
        return Text(KeyLang.noUser.tr());
      },
    );
  }
}
