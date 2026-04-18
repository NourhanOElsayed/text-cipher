import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_enums.dart';
import '../../../core/widgets/alphabet_grid.dart';
import '../providers/vigenere_cubit.dart';
import '../widgets/vigenere_controls_section.dart';
import '../widgets/vigenere_input_section.dart';
import '../widgets/vigenere_output_section.dart';

class VigenereScreen extends StatelessWidget {
  const VigenereScreen({super.key, required this.mode});

  final EncryptionMode mode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigenereCubit, VigenereState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VigenereInputSection(state: state, mode: mode),
              const SizedBox(height: 20),

              VigenereControlsSection(state: state, mode: mode),
              const Spacer(),

              Center(
                child: AlphabetGrid(
                  activeIndex: state.activeGridIndex,
                  isTracing: state.isTracing,
                ),
              ),
              const Spacer(),

              VigenereOutputSection(outputText: state.outputText, mode: mode),
            ],
          ),
        );
      },
    );
  }
}
