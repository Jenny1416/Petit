import 'package:flutter/material.dart';
import '../../../../app/router/app_router.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../app/theme/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fondo blanco
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // Logo centrado en la parte superior
              Expanded(
                child: Center(
                  child: const AppLogo(),
                ),
              ),

              // Botón "Empecemos"
              PrimaryButton(
                text: "Empecemos",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRouter.register);
                },
              ),
              const SizedBox(height: 16),

              // Texto "Ya tengo una cuenta" con ícono
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRouter.login);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ya tengo una cuenta",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32), // espacio inferior
            ],
          ),
        ),
      ),
    );
  }
}
