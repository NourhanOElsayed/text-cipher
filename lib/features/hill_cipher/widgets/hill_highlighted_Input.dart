import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_theme.dart';

class HillHighlightedInput extends StatelessWidget {
  final String text;
  final List<int> activeIndices;

  const HillHighlightedInput({
    super.key,
    required this.text,
    required this.activeIndices,
  });

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return Text('Input Text...', style: AppTheme.cipherTextStyle.copyWith(color: AppColors.textSecondary));
    }

    List<TextSpan> spans = [];
    
    int cleanIndex = 0;
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
        bool isActive = activeIndices.contains(cleanIndex);
        spans.add(TextSpan(
          text: char,
          style: isActive
              ? const TextStyle(
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )
              : AppTheme.cipherTextStyle,
        ));
        cleanIndex++;
      } else {
        spans.add(TextSpan(text: char, style: AppTheme.cipherTextStyle));
      }
    }

    return RichText(text: TextSpan(children: spans));
  }
}