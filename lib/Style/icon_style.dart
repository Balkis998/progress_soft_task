import 'package:flutter/material.dart';

class IconButtonStyleWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;

  const IconButtonStyleWidget({super.key, this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: onPressed,
        icon: icon);
  }
}
