import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../../../core/constants/app_colors.dart';

class AppDragArea extends StatelessWidget {
  const AppDragArea({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        height: 32,
        color: AppColors.sidebarBackground,

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 12),
              child: Text(
                'TextCipher',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w100,
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const Spacer(),
            // MINIMIZE BUTTON
            IconButton(
              icon: const Icon(Icons.remove_rounded, size: 16),
              color: AppColors.textSecondary,
              hoverColor: AppColors.surfaceLight,
              splashRadius: 20,
              padding: EdgeInsets.zero,
              onPressed: () async {
                await windowManager.minimize();
              },
            ),

            // MAXIMIZE / RESTORE BUTTON
            IconButton(
              icon: const Icon(Icons.crop_square, size: 16),
              color: AppColors.textSecondary,
              hoverColor: AppColors.surfaceLight,
              splashRadius: 16,
              padding: EdgeInsets.zero,
              onPressed: () async {
                if (await windowManager.isMaximized()) {
                  await windowManager.unmaximize();
                } else {
                  await windowManager.maximize();
                }
              },
            ),

            // CLOSE BUTTON
            IconButton(
              icon: const Icon(Icons.close, size: 16),
              color: AppColors.textSecondary,
              hoverColor: Colors.red,
              splashRadius: 16,
              padding: EdgeInsets.zero,
              onPressed: () async {
                await windowManager.close();
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
