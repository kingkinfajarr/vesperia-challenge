import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({
    Key? key,
    this.buttonColor,
    this.borderColor,
    this.textColor,
    this.iconSource,
    this.icon,
    this.iconSize,
    required this.onClick,
    required this.textLabel,
    this.side,
    this.isLoading = false,
  }) : super(key: key);

  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;
  final String? iconSource;
  final IconData? icon;
  final double? iconSize;
  final Function onClick;
  final String textLabel;
  final BorderSide? side;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: borderColor != null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(width: 1.5, color: borderColor!),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        side: side,
      ),
      onPressed: () {
        if (!isLoading) {
          onClick();
        }
      },
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (iconSource != null)
                  Image.asset(
                    iconSource ?? "",
                    height: iconSize ?? 24,
                    width: iconSize ?? 24,
                  )
                else if (icon != null)
                  Icon(icon, size: iconSize ?? 24),
                if (iconSource != null || icon != null)
                  const SizedBox(width: 8),
                Text(
                  textLabel,
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );
  }
}
