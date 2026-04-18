import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('TextCipher Engine Initialized!'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Test Theme Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
