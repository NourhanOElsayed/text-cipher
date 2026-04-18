import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../../core/constants/app_colors.dart';
import '../provider/caesar_cubit.dart';

class CaesarSliderSection extends StatelessWidget {
  final CaesarState state;

  const CaesarSliderSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Key',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SfSliderTheme(
            data: SfSliderThemeData(
              activeTrackColor: AppColors.primaryPurple,
              inactiveTrackColor: AppColors.surfaceLight,
              thumbColor: AppColors.primaryPurple,
              activeTrackHeight: 8,
              inactiveTrackHeight: 8,
              thumbRadius: 10,
            ),
            child: SfSlider(
              min: 1.0,
              max: 25.0,
              value: state.shiftKey.toDouble(),
              interval: 1,
              stepSize: 1,
              onChanged: state.isAnimating
                  ? null
                  : (dynamic newValue) {
                      context.read<CaesarCubit>().onKeyChanged(
                        newValue.toInt(),
                      );
                    },
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          state.shiftKey.toString(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.primaryPurple,
          ),
        ),
      ],
    );
  }
}
