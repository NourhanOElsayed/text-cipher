import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_cipher/features/vigenere_cipher/providers/vigenere_cubit.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_enums.dart';
import '../../../core/theme/app_theme.dart';
import '../../caesar_cipher/widgets/highlighted_input.dart';

class VigenereInputSection extends StatefulWidget {
  const VigenereInputSection({
    super.key,
    required this.state,
    required this.mode,
  });

  final VigenereState state;
  final EncryptionMode mode;

  @override
  State<VigenereInputSection> createState() => _VigenereInputSectionState();
}

class _VigenereInputSectionState extends State<VigenereInputSection> {
  late final TextEditingController _inputController;
  late final TextEditingController _keyController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: widget.state.inputText);
    _keyController = TextEditingController(text: widget.state.keyword);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- 1. MAIN INPUT TEXT AREA ---
        Text(
          widget.mode == EncryptionMode.encryption
              ? 'Input Text'
              : 'Encrypted Text',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.state.isAnimating
              ? HighlightedInput(
                  text: widget.state.inputText,
                  activeIndex: widget.state.activeInputIndex,
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
                    hintText: widget.mode == EncryptionMode.encryption
                        ? 'Type your message'
                        : 'Type the encrypted message',
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
                    context.read<VigenereCubit>().onInputTextChanged(value);
                  },
                ),
        ),

        const SizedBox(height: 24),

        // --- 2. KEYWORD INPUT AREA ---
        Text(
          'Key',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.state.isAnimating
              ? HighlightedInput(
                  text: widget.state.keyword,
                  activeIndex: widget.state.activeKeyIndex,
                )
              : TextField(
                  controller: _keyController,
                  style: AppTheme.cipherTextStyle.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter keyword',
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
                    context.read<VigenereCubit>().onKeyChanged(value);
                  },
                ),
        ),
      ],
    );
  }
}
