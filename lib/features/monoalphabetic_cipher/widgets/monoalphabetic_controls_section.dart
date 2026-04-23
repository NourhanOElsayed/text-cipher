import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_cipher/core/widgets/typewriter_equation.dart';
import 'package:text_cipher/features/monoalphabetic_cipher/provider/monoalphabetic_cubit.dart';
import '../../../core/constants/app_enums.dart';
import '../../home/widgets/custom_button.dart';
class MonoalphabeticControlsSection extends StatelessWidget {
  const MonoalphabeticControlsSection({
    super.key,
    required this.state,
    required this.mode,
  });

  final MonoalphabeticState state;
  final EncryptionMode mode;

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
          onPressed: state.isAnimating || state.inputText.isEmpty || state.keyAlphabet.length != 26
              ? null
              : () {
                  FocusScope.of(context).unfocus();
                  context.read<MonoalphabeticCubit>().processText(isEncrypting: isEncrypting);
                },
        ),
        const SizedBox(width: 16),
        CustomButton(
          isOn: false,
          text: 'Random Key',
          onPressed: state.isAnimating 
              ? null 
              : () {
                  FocusScope.of(context).unfocus();
                  context.read<MonoalphabeticCubit>().generateRandomKey();
                },
        ),
        const SizedBox(width: 32),
        TypewriterEquation(equation: state.currentEquation),
      ],
    );
  }
}