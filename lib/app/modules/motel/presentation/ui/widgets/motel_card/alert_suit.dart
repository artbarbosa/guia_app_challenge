import 'package:app_challenge/app/core/shared/consts/app_colors.dart';
import 'package:flutter/material.dart';

class AlertSuit extends StatelessWidget {
  final int quantity;

  const AlertSuit({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.info_outline_rounded,
          color: AppColors.primary,
          size: 18,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "Só mais $quantity pelo app",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
