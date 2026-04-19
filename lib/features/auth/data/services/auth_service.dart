import '../models/user_model.dart';

class AuthService {
  // Simulación de base de datos en memoria
  final List<UserModel> _users = [];

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final user = _users.firstWhere(
            (u) => u.email == email && u.password == password,
      );
      return user != null;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String email, String password, String phone) async {
    await Future.delayed(const Duration(seconds: 1));

    final exists = _users.any((u) => u.email == email);
    if (exists) return false;

    _users.add(UserModel(
      email: email,
      password: password,
      phone: phone,
    ));

    return true;
  }

  Future<bool> sendResetLink(String email) async {
    await Future.delayed(const Duration(seconds: 1));

    final exists = _users.any((u) => u.email == email);
    return exists;
  }

  Future<bool> resetPassword(String email, String newPassword) async {
    await Future.delayed(const Duration(seconds: 1));

    final index = _users.indexWhere((u) => u.email == email);

    if (index == -1) return false;

    _users[index] = UserModel(
      email: email,
      password: newPassword,
      phone: _users[index].phone,
    );

    return true;
  }
}