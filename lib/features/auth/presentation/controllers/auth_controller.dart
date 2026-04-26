import '../../data/services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<String?> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Completa todos los campos';
    }

    final user = await _authService.login(email, password);

    if (user == null) {
      return 'Credenciales incorrectas';
    }

    return null;
  }

  Future<String?> register(
      String email,
      String password,
      String confirmPassword,
      String phone,
      String? imagePath,
      ) async {
    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty) {
      return 'Completa todos los campos';
    }

    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }

    final success = await _authService.register(email, password, phone, imagePath);

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

    if (success) {
      _authService.passwordResetEmail = email; // Guardamos el email globalmente
      return null;
    }

    return 'El correo no está registrado';
  }

  Future<String?> resetPassword(
      String email,
      String newPassword,
      String confirmPassword,
      ) async {
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      return 'Completa todos los campos';
    }

    if (newPassword != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }

    final success = await _authService.resetPassword(email, newPassword);

    if (!success) {
      return 'Error al actualizar contraseña';
    }

    return null;
  }

  void logout() {
    _authService.logout();
  }

  String? get currentResetEmail => _authService.passwordResetEmail;
}
