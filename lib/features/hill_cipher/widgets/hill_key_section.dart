import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_cipher/features/hill_cipher/provider/hill_cubit.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_theme.dart';

class HillKeySection extends StatelessWidget {
  final HillState state;

  const HillKeySection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Key Matrix Size',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 16),
            _buildSizeButton(context, 2),
            const SizedBox(width: 8),
            _buildSizeButton(context, 3),
            const SizedBox(width: 8),
            _buildSizeButton(context, 4),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: state.matrixSize * 70.0,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: state.matrixSize,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: state.matrixSize * state.matrixSize,
            itemBuilder: (context, index) {
              int currentRow = index ~/ state.matrixSize;
              bool isActive =
                  state.isAnimating && state.activeMatrixRow == currentRow;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primaryPurple
                      : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: state.isAnimating
                    ? Text(
                        state.keyMatrix[index],
                        style: AppTheme.cipherTextStyle.copyWith(
                          color: isActive
                              ? Colors.white
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    : TextField(
                        textAlign: TextAlign.center,
                        style: AppTheme.cipherTextStyle.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        controller: TextEditingController.fromValue(
                          TextEditingValue(
                            text: state.keyMatrix[index],
                            selection: TextSelection.collapsed(
                              offset: state.keyMatrix[index].length,
                            ),
                          ),
                        ),
                        onChanged: (val) {
                          context.read<HillCubit>().onKeyMatrixChanged(
                            index,
                            val,
                          );
                        },
                      ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSizeButton(BuildContext context, int size) {
    bool isSelected = state.matrixSize == size;
    return GestureDetector(
      onTap: state.isAnimating
          ? null
          : () => context.read<HillCubit>().onMatrixSizeChanged(size),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryPurple : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '${size}x$size',
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
