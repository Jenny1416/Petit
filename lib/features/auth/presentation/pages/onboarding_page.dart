import 'package:flutter/material.dart';
import '../../../../app/router/app_router.dart';
import '../../../../core/widgets/primary_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Placeholder(fallbackHeight: 250),
            const SizedBox(height: 24),
            const Text(
              'Busca felicidad para tu mascota. Aquí la encuentras',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Empezar',
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.home);
              },
            ),
          ],
        ),
      ),
    );
  }
}
