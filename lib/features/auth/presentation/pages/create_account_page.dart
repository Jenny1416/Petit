import 'package:flutter/material.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                const AppLogo(),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Crear cuenta',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                const CustomTextField(hintText: 'Correo electrónico'),
                const SizedBox(height: 12),
                const CustomTextField(hintText: 'Contraseña', obscureText: true),
                const SizedBox(height: 12),
                const CustomTextField(hintText: 'Nueva contraseña', obscureText: true),
                const SizedBox(height: 12),
                const CustomTextField(hintText: 'Número de teléfono'),
                const SizedBox(height: 24),
                PrimaryButton(text: 'Hecho', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
