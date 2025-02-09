import 'package:app_challenge/app/core/shared/consts/app_colors.dart';
import 'package:flutter/material.dart';

class ToggleBookingButton extends StatefulWidget {
  final ValueChanged<bool> onToggleChanged;

  const ToggleBookingButton({super.key, required this.onToggleChanged});

  @override
  State<ToggleBookingButton> createState() => _ToggleBookingButtonState();
}

class _ToggleBookingButtonState extends State<ToggleBookingButton> {
  bool isNowSelected = true;

  void _toggleSelection(bool isNow) {
    setState(() {
      isNowSelected = isNow;
    });
    widget.onToggleChanged(isNow);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryButton,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            text: "ir agora",
            icon: Icons.bolt,
            isSelected: isNowSelected,
            onTap: () => _toggleSelection(true),
          ),
          _buildButton(
            text: "ir outro dia",
            icon: Icons.calendar_month,
            isSelected: !isNowSelected,
            onTap: () => _toggleSelection(false),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : AppColors.secondaryButton,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.secondaryButton : Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.black87 : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
