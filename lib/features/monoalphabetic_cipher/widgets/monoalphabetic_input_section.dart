import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_cipher/features/monoalphabetic_cipher/provider/monoalphabetic_cubit.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_enums.dart';
import '../../../core/theme/app_theme.dart';
import '../../caesar_cipher/widgets/highlighted_input.dart';

class MonoalphabeticInputSection extends StatefulWidget {
  const MonoalphabeticInputSection({
    super.key,
    required this.state,
    required this.mode,
  });

  final MonoalphabeticState state;
  final EncryptionMode mode;

  @override
  State<MonoalphabeticInputSection> createState() =>
      _MonoalphabeticInputSectionState();
}

class _MonoalphabeticInputSectionState
    extends State<MonoalphabeticInputSection> {
  late final TextEditingController _inputController;
  late final TextEditingController _keyController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: widget.state.inputText);
    _keyController = TextEditingController(text: widget.state.keyAlphabet);
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
                    context.read<MonoalphabeticCubit>().onInputTextChanged(
                      value,
                    );
                  },
                ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Key (26 Letters)',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Text(
              '${widget.state.keyAlphabet.length}/26',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: widget.state.keyAlphabet.length == 26
                    ? AppColors.textSecondary
                    : Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
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
              ? Text(
                  widget.state.keyAlphabet,
                  style: AppTheme.cipherTextStyle.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                )
              : TextField(
                  controller: _keyController,
                  maxLength: 26,
                  style: AppTheme.cipherTextStyle.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: 'Enter 26 letter key',
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
                    context.read<MonoalphabeticCubit>().onKeyChanged(value);
                  },
                ),
        ),
      ],
    );
  }
}
