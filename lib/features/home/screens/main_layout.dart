import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_cipher/core/constants/app_enums.dart';
import 'package:text_cipher/features/caesar_cipher/screens/caesar_screen.dart';
import 'package:text_cipher/features/home/widgets/app_drag_area.dart';
import 'package:text_cipher/features/playfair_cipher/screens/playfair_screen.dart';
import 'package:text_cipher/features/vigenere_cipher/screens/vigenere_screen.dart';

import '../../caesar_cipher/provider/caesar_cubit.dart';
import '../../playfair_cipher/providers/playfair_cubit.dart';
import '../../vigenere_cipher/providers/vigenere_cubit.dart';
import '../widgets/left_sidebar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  EncryptionMode encryptionMode = EncryptionMode.encryption;
  CipherType cipherType = CipherType.caesar;
  Widget cipherScreen() {
    switch (cipherType) {
      case CipherType.caesar:
        return CaesarScreen(mode: encryptionMode);
      case CipherType.vigenere:
        return VigenereScreen(mode: encryptionMode);
      default:
        return PlayfairScreen(mode: encryptionMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppDragArea(),
          Expanded(
            child: Row(
              children: [
                LeftSidebar(
                  currentMode: encryptionMode,
                  currentCipher: cipherType,
                  onModeChanged: (newMode) {
                    if (encryptionMode != newMode) {
                      // 1. Wipe the memory of all cubits
                      context.read<CaesarCubit>().reset();
                      context.read<VigenereCubit>().reset();
                      context.read<PlayfairCubit>().reset();

                      // 2. Update the UI state
                      setState(() {
                        encryptionMode = newMode;
                      });
                    }
                  },
                  onCipherChanged: (newCipher) {
                    if (cipherType != newCipher) {
                      // 1. Wipe the memory of all cubits
                      context.read<CaesarCubit>().reset();
                      context.read<VigenereCubit>().reset();
                      context.read<PlayfairCubit>().reset();

                      // 2. Update the UI state
                      setState(() {
                        cipherType = newCipher;
                      });
                    }
                  },
                ),
                Expanded(child: cipherScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
