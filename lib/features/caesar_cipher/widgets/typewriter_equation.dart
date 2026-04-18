import 'package:flutter/material.dart';
import 'package:text_cipher/core/constants/app_colors.dart';

class TypewriterEquation extends StatelessWidget {
  const TypewriterEquation({super.key, required this.equation});

  final String equation;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      key: ValueKey<String>(equation),
      tween: IntTween(begin: 0, end: equation.length),
      duration: Duration(milliseconds: equation.length * 30),
      builder: (context, value, child) {
        return Text(
          equation.substring(0, value),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
        );
      },
    );
  }
}
