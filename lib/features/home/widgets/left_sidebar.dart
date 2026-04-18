import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/app_enums.dart';
import 'custom_button.dart';

class LeftSidebar extends StatelessWidget {
  final EncryptionMode currentMode;
  final CipherType currentCipher;
  final ValueChanged<EncryptionMode> onModeChanged;
  final ValueChanged<CipherType> onCipherChanged;

  const LeftSidebar({
    super.key,
    required this.currentMode,
    required this.currentCipher,
    required this.onModeChanged,
    required this.onCipherChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.fromLTRB(32, 40, 32, 52),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/images/title_logo.svg',
            width: 20,
            height: 20,
          ),
          const SizedBox(height: 52),
          Text(
            'Mode',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              isOn: currentMode == EncryptionMode.encryption,
              text: EncryptionMode.encryption.modeTitle,
              onPressed: () => onModeChanged(EncryptionMode.encryption),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              isOn: currentMode == EncryptionMode.decryption,
              text: EncryptionMode.decryption.modeTitle,
              onPressed: () => onModeChanged(EncryptionMode.decryption),
            ),
          ),
          const SizedBox(height: 52),
          Text(
            'Cipher',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              isOn: currentCipher == CipherType.caesar,
              text: CipherType.caesar.cipherTitle,
              onPressed: () => onCipherChanged(CipherType.caesar),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              isOn: currentCipher == CipherType.vigenere,
              text: CipherType.vigenere.cipherTitle,
              onPressed: () => onCipherChanged(CipherType.vigenere),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              isOn: currentCipher == CipherType.monoalphabetic,
              text: CipherType.monoalphabetic.cipherTitle,
              onPressed: () => onCipherChanged(CipherType.monoalphabetic),
            ),
          ),
        ],
      ),
    );
  }
}
