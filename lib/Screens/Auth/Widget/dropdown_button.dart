import 'package:flutter/material.dart';
import '../../../Style/form_style.dart';
import '../../../Theme/app_colors.dart';
import '../../../Theme/text_theme.dart';

class MainDropDownMenu extends StatelessWidget {
  final List<String> items;
  final double? width;
  final Widget? icon;
  final String hint;
  final void Function()? onTap;
  final String? value;
  final String? errorText;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final FocusNode? focusNode;
  final void Function(String?)? onSaved;
  const MainDropDownMenu({
    super.key,
    required this.items,
    this.width,
    this.icon,
    required this.hint,
    this.errorText,
    this.validator,
    required this.onChanged,
    this.value,
    this.focusNode,
    this.onTap,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        isExpanded: true,
        autofocus: false,
        value: value,
        focusNode: focusNode,
        hint: Text(
          hint,
          style: TextThemeStyle.textThemeStyle.titleSmall!
              .copyWith(color: AppColors.hintColor),
        ),
        onSaved: onSaved,
        onTap: onTap,
        decoration: AppStyles.formStyle(hint),
        icon: const Icon(Icons.arrow_drop_down),
        style: const TextStyle(color: Colors.black),
        validator: validator,
        items: items
            .map(
              (value) => DropdownMenuItem(
                value: value,
                child: Text(value),
              ),
            )
            .toList(),
        onChanged: onChanged);
  }
}
