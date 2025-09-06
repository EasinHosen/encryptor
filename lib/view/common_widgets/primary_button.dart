import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.onPressed,
      this.borderColor,
      this.fontColor,
      required this.buttonText,
      this.prefixIcon,
      this.borderRadius,
      this.alignment,
      this.fontSize,
      this.fontWeight,
      this.backgroundColor});

  final void Function()? onPressed;
  final Color? borderColor, fontColor, backgroundColor;
  final String buttonText;
  final Widget? prefixIcon;
  final double? borderRadius, fontSize;
  final MainAxisAlignment? alignment;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.colorPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Row(
        mainAxisAlignment: alignment ?? MainAxisAlignment.center,
        children: [
          if (prefixIcon != null)
            Row(
              children: [
                prefixIcon!,
                const SizedBox(
                  width: 8,
                )
              ],
            ),
          Text(
            buttonText,
            style: TextStyle(
                color: fontColor ?? Colors.white,
                fontSize: fontSize ?? 16,
                fontWeight: fontWeight ?? FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
