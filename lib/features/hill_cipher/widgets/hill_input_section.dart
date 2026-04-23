import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_cipher/features/hill_cipher/provider/hill_cubit.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_enums.dart';
import '../../../core/theme/app_theme.dart';
import 'hill_highlighted_input.dart';

class HillInputSection extends StatefulWidget {
  const HillInputSection({
    super.key,
    required this.state,
    required this.mode,
  });

  final HillState state;
  final EncryptionMode mode;

  @override
  State<HillInputSection> createState() => _HillInputSectionState();
}

class _HillInputSectionState extends State<HillInputSection> {
  late final TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: widget.state.inputText);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.mode == EncryptionMode.encryption ? 'Input Text' : 'Encrypted Text',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.all(16),
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.state.isAnimating
              ? HillHighlightedInput(
                  text: widget.state.inputText,
                  activeIndices: widget.state.activeInputIndices,
                )
              : TextField(
                  controller: _inputController,
                  style: AppTheme.cipherTextStyle.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: widget.mode == EncryptionMode.encryption ? 'Type your message' : 'Type the encrypted message',
                    hintStyle: AppTheme.cipherTextStyle.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) {
                    context.read<HillCubit>().onInputTextChanged(value);
                  },
                ),
        ),
      ],
    );
  }
}