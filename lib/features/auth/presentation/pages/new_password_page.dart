import 'package:flutter/material.dart';
import '../../../../app/router/app_router.dart';
import '../../../../core/widgets/app_logo.dart';
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
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  String? _email;

  @override
  void initState() {
    super.initState();
    // Recuperamos el email directamente del controlador (que lo saca del servicio Singleton)
    _email = controller.currentResetEmail;
  }

  Future<void> handleResetPassword() async {
    if (_email == null || _email!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Sesión de recuperación expirada.')),
      );
      return;
    }

    setState(() => isLoading = true);

    final error = await controller.resetPassword(
      _email!,
      newPasswordController.text.trim(),
      confirmPasswordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (!mounted) return;

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRouter.passwordUpdated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const AppLogo(),
                const SizedBox(height: 32),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Crear nueva contraseña',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Restableciendo contraseña para:\n${_email ?? "Cargando..."}',
                  style: const TextStyle(fontSize: 14, color: Colors.blueGrey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  hintText: 'Nueva contraseña',
                  controller: newPasswordController,
                  obscureText: _obscureNewPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscureNewPassword = !_obscureNewPassword);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Confirmar nueva contraseña',
                  controller: confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                    },
                  ),
                ),
                const SizedBox(height: 40),
                PrimaryButton(
                  text: isLoading ? 'Actualizando...' : 'Actualizar contraseña',
                  onPressed: isLoading ? null : handleResetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
