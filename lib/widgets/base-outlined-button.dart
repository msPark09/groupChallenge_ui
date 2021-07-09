import 'package:flutter/material.dart';

const double defaultBorderRadius = 4.0;

class BaseOutlinedButton extends StatelessWidget {
  final Function onPressed;
  final Function onLongPress;
  final Color backgroundColor;
  final String buttonLabel;
  final Color textColor;

  BaseOutlinedButton(
      {@required this.onPressed,
      this.onLongPress,
      @required this.buttonLabel,
      this.backgroundColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
      ),
      onLongPress: onLongPress,
      onPressed: onPressed,
      child: Padding(
          padding:
              EdgeInsets.only(left: 16.0, right: 16.0, top: 12, bottom: 12),
          child: Text(buttonLabel,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: textColor))),
    );
  }
}
