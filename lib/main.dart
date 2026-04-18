import 'package:flutter/material.dart';
import 'package:text_cipher/features/home/screens/main_layout.dart';
import 'package:window_manager/window_manager.dart';

import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1100, 750),
    minimumSize: Size(850, 600), // Prevents the user from shrinking it too much
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const TextCipherApp());
}

class TextCipherApp extends StatelessWidget {
  const TextCipherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextCipher',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,

      home: MainLayout(),
    );
  }
}
