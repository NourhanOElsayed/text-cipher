import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_enums.dart';
import '../providers/playfair_cubit.dart';
import '../widgets/playfair_input_section.dart';
import '../widgets/playfair_middle_section.dart';
import '../widgets/playfair_output_section.dart';

class PlayfairScreen extends StatelessWidget {
  const PlayfairScreen({super.key, required this.mode});

  final EncryptionMode mode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayfairCubit, PlayfairState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlayfairInputSection(state: state, mode: mode),

              const Spacer(),
              PlayfairMiddleSection(state: state, mode: mode),
              const Spacer(),

              PlayfairOutputSection(outputText: state.outputText, mode: mode),
            ],
          ),
        );
      },
    );
  }
}
