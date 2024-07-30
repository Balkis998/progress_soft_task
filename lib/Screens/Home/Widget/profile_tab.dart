import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/Style/assets.dart';
import 'package:flutter_task/Widgets/main_button.dart';

import '../../../BloC/Profile/profile_cubit.dart';
import '../../../Language/key_lang.dart';
import '../../../Theme/text_theme.dart';
import '../../Auth/Widget/form_field.dart';
import '../../Auth/login_screen.dart';

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
                    SvgPicture.asset(SvgAssets.person),
                    SizedBox(width: 16.w),
                    Text(
                      KeyLang.personalInfo.tr(),
                      style: TextThemeStyle.textThemeStyle.titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  KeyLang.fullName.tr(),
                  style: TextThemeStyle.textThemeStyle.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                FormFieldWidget(
                  hint: userData['fullName'] ?? KeyLang.fullName.tr(),
                  hintStyle: TextThemeStyle.textThemeStyle.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  readOnly: true,
                ),
                SizedBox(height: 8.h),
                Text(
                  KeyLang.phone.tr(),
                  style: TextThemeStyle.textThemeStyle.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                FormFieldWidget(
                  hint: userData['phone'] ?? KeyLang.phone.tr(),
                  hintStyle: TextThemeStyle.textThemeStyle.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  readOnly: true,
                ),
                SizedBox(height: 8.h),
                Text(
                  KeyLang.gender.tr(),
                  style: TextThemeStyle.textThemeStyle.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                FormFieldWidget(
                  hint: userData['gender'] ?? KeyLang.gender.tr(),
                  hintStyle: TextThemeStyle.textThemeStyle.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  readOnly: true,
                ),
                SizedBox(height: 8.h),
                Text(
                  KeyLang.age.tr(),
                  style: TextThemeStyle.textThemeStyle.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                FormFieldWidget(
                  hint: userData['age'] ?? KeyLang.age.tr(),
                  hintStyle: TextThemeStyle.textThemeStyle.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  readOnly: true,
                ),
                const Spacer(),
                SizedBox(height: 16.h),
                MainButton(
                  text: KeyLang.logout.tr(),
                  width: double.infinity,
                  onPressed: () async {
                    const FlutterSecureStorage secureStorage =
                        FlutterSecureStorage();
                    await secureStorage.delete(
                        key: 'user_token'); // delete token from secure storage
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.id, (route) => false);
                  },
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
