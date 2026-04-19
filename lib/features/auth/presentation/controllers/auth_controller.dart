import '../../data/services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<String?> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Completa todos los campos';
    }

    final success = await _authService.login(email, password);

    if (!success) {
      return 'Credenciales incorrectas';
    }

    return null;
  }

  Future<String?> register(
      String email, String password, String confirmPassword, String phone) async {
    if (email.isEmpty || password.isEmpty || phone.isEmpty) {
      return 'Completa todos los campos';
    }

    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }

    final success = await _authService.register(email, password, phone);

    if (!success) {
      return 'El usuario ya existe';
    }

    return null;
  }

  Future<String?> sendResetLink(String email) async {
    if (email.isEmpty) {
      return 'Ingresa tu correo';
    }

    final success = await _authService.sendResetLink(email);

    if (!success) {
      return 'El correo no está registrado';
    }

    return null;
  }

  Future<String?> resetPassword(String email, String newPassword) async {
    if (newPassword.isEmpty) {
      return 'Ingresa la nueva contraseña';
    }

    final success = await _authService.resetPassword(email, newPassword);

    if (!success) {
      return 'Error al actualizar contraseña';
    }

    return null;
  }
}