import 'package:flutter/material.dart';
import '../../../../app/router/app_router.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  final AuthController controller = AuthController();

  bool isLoading = false;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> handleResetPassword() async {
    setState(() {
      isLoading = true;
    });

    final email =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';

    final error = await controller.resetPassword(
      email,
      newPasswordController.text.trim(),
      confirmPasswordController.text.trim(),
    );

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppRouter.passwordUpdated,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear nueva contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            CustomTextField(
              hintText: 'Nueva contraseña',
              obscureText: true,
              controller: newPasswordController,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Confirmar contraseña',
              obscureText: true,
              controller: confirmPasswordController,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: isLoading ? 'Actualizando...' : 'Actualizar contraseña',
              onPressed: isLoading ? null : handleResetPassword,
            ),
          ],
        ),
      ),
    );
  }
}