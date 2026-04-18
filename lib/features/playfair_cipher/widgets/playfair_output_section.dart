import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_enums.dart';
import '../../../core/theme/app_theme.dart';

class PlayfairOutputSection extends StatelessWidget {
  const PlayfairOutputSection({
    super.key,
    required this.outputText,
    required this.mode,
  });

  final String outputText;
  final EncryptionMode mode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mode == EncryptionMode.encryption
              ? 'Encrypted Text'
              : 'Decrypted Text',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.all(16),
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            outputText.isEmpty
                ? (mode == EncryptionMode.encryption
                      ? 'Your encrypted text'
                      : 'Your decrypted text')
                : outputText,
            style: AppTheme.cipherTextStyle.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
