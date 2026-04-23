import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_cipher/features/hill_cipher/provider/hill_cubit.dart';
import '../../../core/constants/app_enums.dart';

import '../widgets/hill_input_section.dart';
import '../widgets/hill_key_section.dart';
import '../widgets/hill_middle_section.dart';
import '../widgets/hill_output_section.dart';

class HillScreen extends StatelessWidget {
  const HillScreen({super.key, required this.mode});

  final EncryptionMode mode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HillCubit, HillState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HillInputSection(state: state, mode: mode),
                      const SizedBox(height: 32),
                      HillKeySection(state: state),
                      const SizedBox(height: 32),
                      HillMiddleSection(state: state, mode: mode),
                    ],
                  ),
                ),
              ),

              HillOutputSection(outputText: state.outputText, mode: mode),
            ],
          ),
        );
      },
    );
  }
}
