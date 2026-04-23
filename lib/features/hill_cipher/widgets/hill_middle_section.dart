import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_cipher/features/hill_cipher/provider/hill_cubit.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_enums.dart';
import '../../home/widgets/custom_button.dart';

class HillMiddleSection extends StatelessWidget {
  final HillState state;
  final EncryptionMode mode;

  const HillMiddleSection({super.key, required this.state, required this.mode});

  @override
  Widget build(BuildContext context) {
    final bool isEncrypting = mode == EncryptionMode.encryption;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomButton(
          isOn: !state.isAnimating,
          text: state.isAnimating
              ? (isEncrypting ? 'Encrypting...' : 'Decrypting...')
              : (isEncrypting ? 'Encrypt Text' : 'Decrypt Text'),
          onPressed: state.isAnimating || state.inputText.isEmpty
              ? null
              : () {
                  FocusScope.of(context).unfocus();
                  context.read<HillCubit>().processText(
                    isEncrypting: isEncrypting,
                  );
                },
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Text(
            state.currentEquation,
            style: const TextStyle(
              fontFamily: 'GoogleSansCode',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
