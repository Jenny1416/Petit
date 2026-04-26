class UserModel {
  final String email;
  final String password;
  final String phone;
  final String? imagePath;
  final List<String> activityLogs;
  final List<int> favorites;

  UserModel({
    required this.email,
    required this.password,
    required this.phone,
    this.imagePath,
    this.activityLogs = const [],
    this.favorites = const [],
  });

  UserModel copyWith({
    String? email,
    String? password,
    String? phone,
    String? imagePath,
    List<String>? activityLogs,
    List<int>? favorites,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      imagePath: imagePath ?? this.imagePath,
      activityLogs: activityLogs ?? this.activityLogs,
      favorites: favorites ?? this.favorites,
    );
  }
}
