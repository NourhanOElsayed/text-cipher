import 'package:flutter/material.dart';
import 'package:text_cipher/core/constants/app_colors.dart';
import 'package:text_cipher/core/theme/app_theme.dart';

class HighlightedInput extends StatelessWidget {
  const HighlightedInput({super.key, required this.text, this.activeIndex});

  final String text;
  final int? activeIndex;

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return Text(
        "Type your input text here...",
        style: AppTheme.cipherTextStyle.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      );
    }
    if (activeIndex == null || activeIndex! >= text.length) {
      return Text(text, style: AppTheme.cipherTextStyle);
    }
    return RichText(
      text: TextSpan(
        style: AppTheme.cipherTextStyle,
        children: [
          TextSpan(
            text: text.substring(0, activeIndex),
            style: AppTheme.cipherTextStyle.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: text[activeIndex!],
            style: AppTheme.cipherTextStyle.copyWith(
              color: AppColors.secondaryPurple,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: text.substring(activeIndex! + 1),
            style: AppTheme.cipherTextStyle.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
