import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.pets, color: Colors.white),
        ),
        SizedBox(width: 8),
        Text(
          'PETIT',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
