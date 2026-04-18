import 'package:flutter/material.dart';
import 'package:text_cipher/core/constants/app_enums.dart';
import 'package:text_cipher/features/caesar_cipher/screens/caesar_screen.dart';
import 'package:text_cipher/features/home/widgets/app_drag_area.dart';

import '../widgets/left_sidebar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  EncryptionMode encryptionMode = EncryptionMode.encryption;
  CipherType cipherType = CipherType.caesar;

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
                    setState(() {
                      encryptionMode = newMode;
                    });
                  },
                  onCipherChanged: (newCipher) {
                    setState(() {
                      cipherType = newCipher;
                    });
                  },
                ),
                Expanded(
                  child: cipherType == CipherType.caesar
                      ? CaesarScreen(mode: encryptionMode)
                      : Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
