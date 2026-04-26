import 'package:flutter/material.dart';
import '../../../../app/router/app_router.dart';
import '../../../../core/widgets/primary_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con imagen
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding_bg.jpg'), // 👈 pon tu imagen aquí
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Degradado oscuro al final
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8), // 👈 oscurece al final
                ],
              ),
            ),
          ),

          // Contenido centrado pero abajo
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // 👈 todo abajo
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '¿Buscas felicidad para tu mascota? ¡Aquí la encuentras!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '¡Encuéntralo aquí, cómpralo ahora!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    text: 'Empezar',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRouter.home);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
