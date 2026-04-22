import 'package:flutter/material.dart';
import '../../../../app/router/app_router.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final AuthController controller = AuthController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> handleRegister() async {
    setState(() {
      isLoading = true;
    });

    final error = await controller.register(
      emailController.text.trim(),
      passwordController.text.trim(),
      confirmPasswordController.text.trim(),
      phoneController.text.trim(),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada correctamente')),
      );

      Navigator.pushReplacementNamed(context, AppRouter.onboarding);
    }
  }

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
                CustomTextField(
                  hintText: 'Correo electrónico',
                  controller: emailController,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Contraseña',
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Confirmar contraseña',
                  obscureText: true,
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Número de teléfono',
                  controller: phoneController,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: isLoading ? 'Cargando...' : 'Hecho',
                  onPressed: isLoading ? null : handleRegister,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}