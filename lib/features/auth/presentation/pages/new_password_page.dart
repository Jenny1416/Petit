import 'package:flutter/material.dart';
import '../../../../app/router/app_router.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear nueva contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const CustomTextField(hintText: 'Nueva contraseña', obscureText: true),
            const SizedBox(height: 12),
            const CustomTextField(hintText: 'Confirmar contraseña', obscureText: true),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Actualizar contraseña',
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRouter.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
