import 'package:flutter/material.dart';
import '../../../../app/router/app_router.dart';
import '../../../../core/widgets/primary_button.dart';

class ForgotPasswordSentPage extends StatelessWidget {
  const ForgotPasswordSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const Icon(
              Icons.mark_email_read_outlined,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            const Text(
              'Hemos enviado un mensaje',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Se envió una instrucción de recuperación a:\n$email',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Continuar',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.newPassword,
                  arguments: email,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}