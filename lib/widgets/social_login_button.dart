import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String? icon;
  final IconData? iconData;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;
  final double borderRadius;

  const SocialLoginButton({
    Key? key,
    required this.text,
    this.icon,
    this.iconData,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height = 50,
    this.borderRadius = 8,
  }) : assert(icon != null || iconData != null, 'Either icon or iconData must be provided'),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? (isDarkMode ? Colors.grey[800] : Colors.white),
          side: BorderSide(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Image.asset(
                icon!,
                width: 24,
                height: 24,
              )
            else if (iconData != null)
              Icon(
                iconData,
                size: 24,
                color: textColor ?? (isDarkMode ? Colors.white : Colors.black87),
              ),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: textColor ?? (isDarkMode ? Colors.white : Colors.black87),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

