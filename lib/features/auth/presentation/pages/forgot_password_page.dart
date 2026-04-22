import 'package:flutter/material.dart';
import '../../../../app/router/app_router.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final AuthController controller = AuthController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> handleSendResetLink() async {
    setState(() {
      isLoading = true;
    });

    final email = emailController.text.trim();
    final error = await controller.sendResetLink(email);

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    } else {
      Navigator.pushNamed(
        context,
        AppRouter.forgotPasswordSent,
        arguments: email,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const AppLogo(),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '¿Has olvidado tu contraseña?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ingresa tu correo electrónico para continuar.',
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: 'Correo electrónico',
              controller: emailController,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: isLoading ? 'Enviando...' : 'Enviar',
              onPressed: isLoading ? null : handleSendResetLink,
            ),
          ],
        ),
      ),
    );
  }
}