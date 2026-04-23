import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class HillMatrix extends StatelessWidget {
  final List<List<int>> matrix;

  const HillMatrix({
    super.key,
    required this.matrix,
  });

  @override
  Widget build(BuildContext context) {
    if (matrix.isEmpty) return const SizedBox.shrink();

    int n = matrix.length;

    return SizedBox(
      width: 280,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: n,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: n * n,
        itemBuilder: (context, index) {
          int row = index ~/ n;
          int col = index % n;
          
          return Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              matrix[row][col].toString(),
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }
}