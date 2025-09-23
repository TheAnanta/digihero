import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  late Box _authBox;
  User? _currentUser;

  // Dummy credentials for the authentication system
  static const String _validUsername = '101';
  static const String _validPassword = 'password';
  static const String _userName = 'Manas Malla';

  AuthService() {
    _initializeAuth();
  }

  // Getters
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser?.isAuthenticated ?? false;
  String get userName => _currentUser?.name ?? '';

  void _initializeAuth() {
    _authBox = Hive.box('gameProgress'); // Use existing box for simplicity
    _loadUserData();
  }

  void _loadUserData() {
    final userData = _authBox.get('user');
    if (userData != null) {
      try {
        _currentUser = User.fromJson(Map<String, dynamic>.from(userData));
      } catch (e) {
        // If there's an error loading user data, clear it
        _currentUser = null;
        _authBox.delete('user');
      }
    }
    notifyListeners();
  }

  void _saveUserData() {
    if (_currentUser != null) {
      _authBox.put('user', _currentUser!.toJson());
    } else {
      _authBox.delete('user');
    }
  }

  /// Attempt to login with provided credentials
  /// Returns true if login is successful, false otherwise
  Future<bool> login(String username, String password) async {
    // Simulate authentication delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (username == _validUsername && password == _validPassword) {
      _currentUser = User(
        username: username,
        name: _userName,
        isAuthenticated: true,
      );
      _saveUserData();
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Logout the current user
  void logout() {
    _currentUser = null;
    _authBox.delete('user');
    notifyListeners();
  }

  /// Check if user has valid credentials stored
  bool hasStoredCredentials() {
    return _currentUser?.isAuthenticated ?? false;
  }

  /// Clear all authentication data (for testing/debugging)
  void clearAuthData() {
    _currentUser = null;
    _authBox.delete('user');
    notifyListeners();
  }

  /// Validate credentials without logging in
  bool validateCredentials(String username, String password) {
    return username == _validUsername && password == _validPassword;
  }
}