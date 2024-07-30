import 'package:country_codes/country_codes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../BloC/Auth/Login/login_bloc.dart';
import '../../../BloC/Auth/Login/login_state.dart';
import '../../../BloC/Config/config_bloc.dart';
import '../../../BloC/Config/config_state.dart';
import '../../../Language/key_lang.dart';
import '../../../Widgets/main_button.dart';
import '../../../Widgets/text_button_widget.dart';
import '../otp_screen.dart';
import '../register_screen.dart';
import 'form_field.dart';
import 'not_register_dialog.dart';
import 'password_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();

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

  _showDialog(BuildContext context) {
    NotRegisterDialog alert = NotRegisterDialog(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (context, state) {
        if (state is ConfigLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ConfigError) {
          return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red)));
        } else if (state is ConfigLoaded) {
          final config = state.config;
          return BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                showDialog(
                  context: context,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
              } else if (state is AuthCodeSent) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPScreen(
                      verificationId: state.verificationId,
                      phone: countryCode + phoneController.text,
                      isLogin: true,
                    ),
                  ),
                );
              } else if (state is AuthSuccess) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(KeyLang.successLogin.tr()),
                ));
              } else if (state is AuthFailure) {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              } else if (state is UserNotRegistered) {
                Navigator.of(context).pop();
                _showDialog(context);
              }
            },
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                children: [
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
                    onChanged: (value) {
                      context
                          .read<LoginCubit>()
                          .phoneNumberChanged(countryCode + value);
                    },
                  ),
                  SizedBox(height: 16.h),
                  PasswordField(
                    passwordController: passwordController,
                    hintText: KeyLang.password.tr(),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null ||
                          !RegExp(config.passwordRegex).hasMatch(value)) {
                        return KeyLang.errorPass.tr();
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<LoginCubit>().passwordChanged(value);
                    },
                  ),
                  SizedBox(height: 32.h),
                  TextButtonWidget(
                    text1: KeyLang.dontHaveAccount.tr(),
                    text2: KeyLang.register.tr(),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RegisterScreen.id);
                    },
                  ),
                  SizedBox(height: 32.h),
                  MainButton(
                    width: double.infinity,
                    text: KeyLang.login.tr(),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        setState(() {
                          autovalidateMode = AutovalidateMode.onUserInteraction;
                        });
                        return;
                      }

                      context.read<LoginCubit>().sendCodePressed();
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
