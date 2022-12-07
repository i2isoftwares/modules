import 'package:flutter/material.dart';
import 'package:optdesk/helpers/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.buttonText,
    this.onPressed,
    this.buttonType = ButtonType.primary,
    this.smallText = false,
    this.width,
    this.margin,
    this.padding,
    this.textSize,
    this.height,
    this.borderColor = Colors.white,
  });

  final String buttonText;
  final ButtonType buttonType;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function()? onPressed;
  final bool smallText;
  final double? textSize;
  final double? height;
  final Color borderColor;

  Color _buttonColor(BuildContext context) {
    if (buttonType == ButtonType.primary) {
      return Colors.black;
    }

    if (buttonType == ButtonType.secondary) {
      return Theme.of(context).primaryColor;
    }

    if (buttonType == ButtonType.third) {
      return Colors.white;
    }
    return primary;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      height: height ?? 55,
      width: width ?? MediaQuery.of(context).size.width * 1,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: buttonType == ButtonType.primary ? primary : buttonType == ButtonType.third ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: textSize ?? (smallText ? 14 : 17),
          ),
        ),

      ),
    );
  }
}

enum ButtonType {
  primary,
  secondary,
  third
}