class User {
  // Private constructor
  User._privateConstructor({
    required this.username,
    required this.email,
    required this.password,
    required this.imageUrl,
  });

  // The single instance of the class
  static User? _instance;

  // Factory constructor to return the single instance
  factory User({
    required String username,
    required String email,
    required String password,
    required String imageUrl,
  }) {
    _instance ??= User._privateConstructor(
      username: username,
      email: email,
      password: password,
      imageUrl: imageUrl,
    );
    return _instance!;
  }

  final String username;
  final String email;
  final String password;
  final String imageUrl;

  // get the instance
  static User? get instance => _instance;

  // Reset the instance (if needed)
  static void resetInstance() {
    _instance = null;
  }
}
