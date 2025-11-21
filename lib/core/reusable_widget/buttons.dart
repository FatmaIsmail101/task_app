import 'package:flutter/material.dart';

import '../size_screen/size_config.dart';

class Button extends StatelessWidget {
  final Color color;

  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.style,
  });

  final Function onPressed;
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
          side: BorderSide(color: color),
        ),
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.heightRatio(12),
          horizontal: SizeConfig.widthRatio(24),
        ),
        backgroundColor: color,
      ),
      child: Text(text, style: style),
    );
  }
}
