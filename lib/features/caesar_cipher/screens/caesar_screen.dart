import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_cipher/core/constants/app_enums.dart';
import 'package:text_cipher/features/caesar_cipher/widgets/alphabet_grid.dart';
import '../provider/caesar_cubit.dart';
import '../widgets/caesar_controls_section.dart';
import '../widgets/caesar_input_section.dart';
import '../widgets/caesar_output_section.dart';
import '../widgets/caesar_slider_section.dart';

class CaesarScreen extends StatelessWidget {
  const CaesarScreen({super.key, required this.mode});

  final EncryptionMode mode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaesarCubit, CaesarState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CaesarInputSection(state: state, mode: mode),
              const SizedBox(height: 20),

              CaesarSliderSection(state: state),
              const SizedBox(height: 20),

              CaesarControlsSection(state: state, mode: mode),
              const Spacer(),

              Center(
                child: AlphabetGrid(
                  activeIndex: state.activeGridIndex,
                  isTracing: state.isTracing,
                ),
              ),
              const Spacer(),

              CaesarOutputSection(outputText: state.outputText, mode: mode),
            ],
          ),
        );
      },
    );
  }
}
