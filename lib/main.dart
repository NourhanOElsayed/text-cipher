import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_cipher/features/caesar_cipher/provider/caesar_cubit.dart';
import 'package:text_cipher/features/home/screens/main_layout.dart';
import 'package:window_manager/window_manager.dart';

import 'core/theme/app_theme.dart';
import 'features/vigenere_cipher/providers/vigenere_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 750),
    minimumSize: Size(1200, 750),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<CaesarCubit>(
          create: (context) {
            return CaesarCubit();
          },
        ),
        BlocProvider<VigenereCubit>(
          create: (context) {
            return VigenereCubit();
          },
        ),
      ],
      child: MaterialApp(
        title: 'TextCipher',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: MainLayout(),
      ),
    );
  }
}
