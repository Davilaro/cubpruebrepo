import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final double? textSize;

  CustomTextButton({
    required this.text,
    this.onPressed,
    this.textColor,
    this.textSize,
    
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: textSize,
          //fontFamily: 'RoundedMplus1c',
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.left
      ),
    );
  }
}