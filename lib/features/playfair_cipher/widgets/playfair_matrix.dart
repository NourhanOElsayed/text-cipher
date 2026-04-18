import 'package:flutter/material.dart';
import 'package:text_cipher/core/constants/app_colors.dart';

class PlayfairMatrix extends StatelessWidget {
  const PlayfairMatrix({
    super.key,
    this.activeIndices = const [],
    this.targetIndices = const [],
    required this.matrix,
  });

  final List<String> matrix;
  final List<int> activeIndices;
  final List<int> targetIndices;

  @override
  Widget build(BuildContext context) {
    if (matrix.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: 280,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: 25,
        itemBuilder: (context, index) {
          bool isActive = activeIndices.contains(index);
          bool isTarget = targetIndices.contains(index);

          Color boxColor = AppColors.surfaceLight;
          if (isTarget) {
            boxColor = AppColors.green;
          } else if (isActive) {
            boxColor = AppColors.secondaryPurple;
          }

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              matrix[index],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isTarget || isActive
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
              ),
            ),
          );
        },
      ),
    );
  }
}
