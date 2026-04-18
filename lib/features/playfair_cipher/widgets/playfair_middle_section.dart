import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_enums.dart';
import '../../home/widgets/custom_button.dart';
import '../providers/playfair_cubit.dart';
import 'playfair_matrix.dart';

class PlayfairMiddleSection extends StatelessWidget {
  final PlayfairState state;
  final EncryptionMode mode;

  const PlayfairMiddleSection({
    super.key,
    required this.state,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEncrypting = mode == EncryptionMode.encryption;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- LEFT COLUMN: Controls, Pairs, and Rules ---
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. The Button
              CustomButton(
                isOn: !state.isAnimating,
                text: state.isAnimating
                    ? (isEncrypting ? 'Encrypting...' : 'Decrypting...')
                    : (isEncrypting ? 'Encrypt Text' : 'Decrypt Text'),
                onPressed: state.isAnimating || state.formattedPairs.isEmpty
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        context.read<PlayfairCubit>().processText(
                          isEncrypting: isEncrypting,
                        );
                      },
              ),
              const SizedBox(height: 32),

              // 2. The Formatted Pairs (e.g., HE LX LO)
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: List.generate(state.formattedPairs.length, (index) {
                  bool isActive = state.activePairIndex == index;
                  return Text(
                    state.formattedPairs[index],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isActive
                          ? AppColors.primaryPurple
                          : AppColors.textSecondary,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // 3. The Multi-line Rule Text
              Text(
                state.currentEquation,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        // --- RIGHT COLUMN: The 5x5 Matrix ---
        PlayfairMatrix(
          matrix: state.matrix,
          activeIndices: state.activeMatrixIndices,
          targetIndices: state.targetMatrixIndices,
        ),
      ],
    );
  }
}
