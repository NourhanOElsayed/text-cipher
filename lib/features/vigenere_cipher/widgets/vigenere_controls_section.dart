import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_enums.dart';
import '../../../core/widgets/typewriter_equation.dart';
import '../../home/widgets/custom_button.dart';
import '../providers/vigenere_cubit.dart';

class VigenereControlsSection extends StatelessWidget {
  final VigenereState state;
  final EncryptionMode mode;

  const VigenereControlsSection({
    super.key,
    required this.state,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEncrypting = mode == EncryptionMode.encryption;
    return Row(
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
                  context.read<VigenereCubit>().processText(
                    isEncrypting: isEncrypting,
                  );
                },
        ),
        const SizedBox(width: 32),
        TypewriterEquation(equation: state.currentEquation),
      ],
    );
  }
}
