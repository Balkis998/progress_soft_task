import 'package:country_codes/country_codes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../BloC/Auth/Register/register_cubit.dart';
import '../../../BloC/Config/config_bloc.dart';
import '../../../BloC/Config/config_state.dart';
import '../../../Language/key_lang.dart';
import '../../../Widgets/main_button.dart';
import '../../../Widgets/text_button_widget.dart';
import '../login_screen.dart';
import '../otp_screen.dart';
import 'dropdown_button.dart';
import 'form_field.dart';
import 'password_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  getCode() async {
    await CountryCodes.init();

    final CountryDetails details = CountryCodes.detailsForLocale();
    setState(() {
      countryCode = details.dialCode ?? '';
    });
  }

  String countryCode = '';

  @override
  void didChangeDependencies() {
    getCode();
    super.didChangeDependencies();
  }

  String? verificationId;

  Future<void> _navigateAndGetResult(
      BuildContext context, String verificationId) async {
    // Navigate to the OTPScreen and wait for the result (user credintial)
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
          phone: countryCode + phoneController.text,
          isLogin: false,
        ),
      ),
    );

    // Use the result from OTPScreen to save to database
    if (result != null) {
      print('result === $result');
      context.read<RegisterCubit>().saveToDatabase(
          fullName: fullNameController.text,
          phone: countryCode + phoneController.text,
          age: ageController.text,
          gender: genderController.text,
          password: passwordController.text,
          userCredential: result);
    }
  }

  String? genderValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigCubit, ConfigState>(builder: (context, state) {
      if (state is ConfigLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is ConfigError) {
        return Center(
            child:
                Text(state.message, style: const TextStyle(color: Colors.red)));
      } else if (state is ConfigLoaded) {
        final config = state.config;
        return BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              showDialog(
                context: context,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );
            } else if (state is PhoneCodeSent) {
              _navigateAndGetResult(context, state.verificationId);
            } else if (state is RegisterSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(KeyLang.successRegister.tr()),
              ));
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            } else if (state is RegisterError) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                children: [
                  FormFieldWidget(
                    hint: KeyLang.fullName.tr(),
                    controller: fullNameController,
                    validator: (value) {
                      if (value == null ||
                          !RegExp(config.nameRegex).hasMatch(value)) {
                        return KeyLang.errorFullName.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  FormFieldWidget(
                    hint: KeyLang.phone.tr(),
                    prefixIcon: Padding(
                      padding:
                          EdgeInsets.only(left: 20.w, right: 20.h, top: 15.h),
                      child: Text(countryCode),
                    ),
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null ||
                          !RegExp(config.mobileRegex).hasMatch(value)) {
                        return KeyLang.errorPhoneNumber.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  FormFieldWidget(
                    hint: KeyLang.age.tr(),
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    validator: (value) {
                      if (value == null ||
                          !RegExp(config.ageRegex).hasMatch(value)) {
                        return KeyLang.errorAge.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  MainDropDownMenu(
                      items: [KeyLang.female.tr(), KeyLang.male.tr()],
                      hint: KeyLang.gender.tr(),
                      validator: (value) {
                        if (value == null ||
                            !RegExp(config.genderRegex)
                                .hasMatch(genderController.text)) {
                          return KeyLang.errorGender.tr();
                        }
                        return null;
                      },
                      value: genderValue,
                      onChanged: (value) {
                        if (value == KeyLang.female.tr()) {
                          genderController.text = 'female';
                        } else {
                          genderController.text = 'male';
                        }
                        genderValue = value;
                        print(genderController.text);
                        setState(() {});
                      }),
                  SizedBox(height: 16.h),
                  PasswordField(
                    passwordController: passwordController,
                    hintText: KeyLang.password.tr(),
                    validator: (value) {
                      if (value == null ||
                          !RegExp(config.passwordRegex).hasMatch(value)) {
                        return KeyLang.errorPass.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  PasswordField(
                    passwordController: passwordConfirmController,
                    hintText: KeyLang.confirmPass.tr(),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value != passwordController.text) {
                        return KeyLang.errorConfirmPass.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32.h),
                  TextButtonWidget(
                    text1: KeyLang.haveAccount.tr(),
                    text2: KeyLang.login.tr(),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.id);
                    },
                  ),
                  SizedBox(height: 32.h),
                  MainButton(
                    width: double.infinity,
                    text: KeyLang.register.tr(),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        setState(() {
                          autovalidateMode = AutovalidateMode.onUserInteraction;
                        });
                        return;
                      }

                      context.read<RegisterCubit>().verifyPhoneNumber(
                            countryCode + phoneController.text,
                          );
                    },
                  )
                ],
              )),
        );
      }
      return Container();
    });
  }
}
