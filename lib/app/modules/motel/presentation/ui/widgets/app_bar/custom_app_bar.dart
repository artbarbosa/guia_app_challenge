import 'package:flutter/material.dart';

import 'toggle_booking_button.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onSearchTap;
  final VoidCallback onNowTap;
  final VoidCallback onAnotherDayTap;

  const CustomAppBar({
    super.key,
    required this.onMenuTap,
    required this.onSearchTap,
    required this.onNowTap,
    required this.onAnotherDayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onMenuTap,
          child: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 28,
          ),
        ),
        SizedBox(width: 10),
        Flexible(
          child: ToggleBookingButton(
            onToggleChanged: (value) {},
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: onSearchTap,
          child: const Icon(
            Icons.search,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    );
  }
}
