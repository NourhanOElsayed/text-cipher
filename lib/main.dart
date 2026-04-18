import 'package:flutter/material.dart';

void main() {
  runApp(const TextCipherApp());
}

class TextCipherApp extends StatelessWidget {
  const TextCipherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
