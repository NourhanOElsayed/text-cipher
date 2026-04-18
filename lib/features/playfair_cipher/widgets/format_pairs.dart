import 'package:flutter/material.dart';
import 'package:text_cipher/core/constants/app_colors.dart';
import 'package:text_cipher/features/playfair_cipher/providers/playfair_cubit.dart';

class FormatPairs extends StatelessWidget {
  const FormatPairs({super.key, required this.state});

  final PlayfairState state;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: List.generate(state.formattedPairs.length, (index) {
        bool isActive = state.activePairIndex == index;

        return Text(
          state.formattedPairs[index],
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: isActive
                ? AppColors.secondaryPurple
                : AppColors.textSecondary,
          ),
        );
      }),
    );
  }
}
