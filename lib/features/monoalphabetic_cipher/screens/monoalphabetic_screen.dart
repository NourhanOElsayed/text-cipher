import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_cipher/core/widgets/alphabet_grid.dart';
import 'package:text_cipher/features/monoalphabetic_cipher/provider/monoalphabetic_cubit.dart';
import '../../../core/constants/app_enums.dart';
import '../widgets/monoalphabetic_controls_section.dart';

import '../widgets/monoalphabetic_input_section.dart';
import '../widgets/monoalphabetic_output_section.dart';

class MonoalphabeticScreen extends StatelessWidget {
  const MonoalphabeticScreen({super.key, required this.mode});

  final EncryptionMode mode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonoalphabeticCubit, MonoalphabeticState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MonoalphabeticInputSection(state: state, mode: mode),
              const SizedBox(height: 20),
              MonoalphabeticControlsSection(state: state, mode: mode),
              const Spacer(),
              Center(
                child: AlphabetGrid(
                  activeIndex: state.activeGridIndex,
                  keyAlphabet: state.keyAlphabet,
                  isTracing: state.isTracing,
                ),
              ),
              const Spacer(),
              MonoalphabeticOutputSection(outputText: state.outputText,
                  mode: mode),
            ],
          ),
        );
      },
    );
  }
}
