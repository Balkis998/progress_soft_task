import 'package:flutter/material.dart';

import '../../../Style/form_style.dart';

class FormFieldWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String hint;
  final Widget? prefixIcon;
  final bool readOnly;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextStyle? hintStyle;
  const FormFieldWidget(
      {super.key,
      this.validator,
      this.textInputAction,
      this.keyboardType,
      required this.hint,
      this.prefixIcon,
      this.onTap,
      this.controller,
      this.onChanged,
      this.readOnly = false,
      this.hintStyle});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      onTap: onTap,
      validator: validator,
      decoration: AppStyles.formStyle(hint,
          hintStyle: hintStyle, prefixIcon: prefixIcon),
    );
  }
}
