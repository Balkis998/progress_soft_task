import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Style/assets.dart';
import '../../../Style/form_style.dart';
import '../../../Theme/text_theme.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {super.key,
      this.passwordController,
      this.hintText,
      required this.validator,
      this.label,
      this.textInputAction,
      this.focusNode,
      this.text,
      this.onChanged,
      this.onTap,
      this.onSaved,
      this.onFieldSubmitted,
      this.filledColor,
      this.style,
      this.iconColor,
      this.boxShadow});

  final TextEditingController? passwordController;
  final String? hintText;
  final String? text;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final Widget? label;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final String? Function(String?) validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final Color? filledColor;
  final TextStyle? style;
  final Color? iconColor;
  final List<BoxShadow>? boxShadow;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextThemeStyle.textThemeStyle.bodyMedium!
          .copyWith(fontWeight: FontWeight.w600),
      autofocus: false,
      controller: widget.passwordController,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: AppStyles.formStyle(
        context: context,
        radius: 10,
        widget.hintText ?? '',
        label: widget.label,
        filledColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        suffixIcon: InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              !showPassword ? SvgAssets.eye : SvgAssets.eye2,
            ),
          ),
          onTap: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),
      ),
      obscureText: !showPassword,
      validator: widget.validator,
    );
  }
}
