// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:text_cipher/core/constants/app_colors.dart';

class AlphabetGrid extends StatelessWidget {
  const AlphabetGrid({super.key, this.activeIndex, this.isTracing = false});

  final int? activeIndex;
  final bool isTracing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: List.generate(26, (index) {
        final bool isActive = activeIndex == index;
        final String letter = String.fromCharCode(index + 65);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isActive
                    ? (isTracing
                          ? AppColors.textSecondary.withOpacity(0.4)
                          : AppColors.primaryPurple)
                    : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                letter,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isActive
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              index.toString(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        );
      }),
    );
  }
}
