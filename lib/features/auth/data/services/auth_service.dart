import '../models/user_model.dart';

class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Simulación de base de datos en memoria
  static final List<UserModel> _users = [
    UserModel(
      email: 'test@test.com',
      password: 'password123',
      phone: '123456789',
    ),
  ];

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  
  // Variable temporal para el flujo de recuperación
  String? passwordResetEmail;

  Future<UserModel?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final cleanEmail = email.trim().toLowerCase();

    try {
      final user = _users.firstWhere(
        (u) => u.email.toLowerCase() == cleanEmail && u.password == password,
      );
      _currentUser = user;
      _logActivity('Inicio de sesión');
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<bool> register(String email, String password, String phone, String? imagePath) async {
    await Future.delayed(const Duration(seconds: 1));
    final cleanEmail = email.trim().toLowerCase();

    final exists = _users.any((u) => u.email.toLowerCase() == cleanEmail);
    if (exists) return false;

    final newUser = UserModel(
      email: cleanEmail,
      password: password,
      phone: phone,
      imagePath: imagePath,
      activityLogs: ['Cuenta creada'],
    );

    _users.add(newUser);
    _currentUser = newUser;
    return true;
  }

  Future<bool> sendResetLink(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    final cleanEmail = email.trim().toLowerCase();
    return _users.any((u) => u.email.toLowerCase() == cleanEmail);
  }

  Future<bool> resetPassword(String email, String newPassword) async {
    await Future.delayed(const Duration(seconds: 1));
    final cleanEmail = email.trim().toLowerCase();

    final index = _users.indexWhere((u) => u.email.toLowerCase() == cleanEmail);
    if (index == -1) return false;

    _users[index] = _users[index].copyWith(password: newPassword);
    
    if (_currentUser?.email.toLowerCase() == cleanEmail) {
      _currentUser = _users[index];
    }
    
    _logActivity('Contraseña actualizada');
    return true;
  }

  void logout() {
    _logActivity('Cierre de sesión');
    _currentUser = null;
  }

  void _logActivity(String activity) {
    if (_currentUser != null) {
      final logEntry = '${DateTime.now().toString().split('.')[0]}: $activity';
      final updatedLogs = List<String>.from(_currentUser!.activityLogs)..add(logEntry);
      _currentUser = _currentUser!.copyWith(activityLogs: updatedLogs);
      
      final index = _users.indexWhere((u) => u.email.toLowerCase() == _currentUser!.email.toLowerCase());
      if (index != -1) {
        _users[index] = _currentUser!;
      }
    }
  }

  void addActivity(String activity) {
    _logActivity(activity);
  }

  Future<void> toggleFavorite(int productId) async {
    if (_currentUser == null) return;

    final currentFavorites = List<int>.from(_currentUser!.favorites);
    if (currentFavorites.contains(productId)) {
      currentFavorites.remove(productId);
    } else {
      currentFavorites.add(productId);
    }

    _currentUser = _currentUser!.copyWith(favorites: currentFavorites);
    
    final index = _users.indexWhere((u) => u.email.toLowerCase() == _currentUser!.email.toLowerCase());
    if (index != -1) {
      _users[index] = _currentUser!;
    }
  }
}
