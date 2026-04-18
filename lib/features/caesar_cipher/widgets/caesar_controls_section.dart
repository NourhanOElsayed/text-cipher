import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_enums.dart';
import '../../home/widgets/custom_button.dart';
import '../provider/caesar_cubit.dart';
import 'typewriter_equation.dart';

class CaesarControlsSection extends StatelessWidget {
  final CaesarState state;
  final EncryptionMode mode;

  const CaesarControlsSection({
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
                  context.read<CaesarCubit>().processText(
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
