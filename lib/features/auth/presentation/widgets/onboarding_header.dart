import 'package:flutter/material.dart';
import '../../../../app/router/app_router.dart';

class OnboardingHeader extends StatelessWidget {
  final String stepText;
  const OnboardingHeader({super.key, required this.stepText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          stepText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRouter.home);
          },
          child: const Text('Saltar'),
        ),
      ],
    );
  }
}
