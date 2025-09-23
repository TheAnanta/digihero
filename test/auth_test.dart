import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:digihero/core/services/auth_service.dart';
import 'package:digihero/core/models/user_model.dart';

void main() {
  group('AuthService Tests', () {
    late AuthService authService;
    late Box mockBox;

    setUp(() async {
      // Initialize Hive for testing
      await Hive.initFlutter();
      mockBox = await Hive.openBox('test_gameProgress');
      authService = AuthService();
    });

    tearDown(() async {
      await mockBox.clear();
      await mockBox.close();
    });

    test('should authenticate with valid credentials', () async {
      // Test valid credentials
      final result = await authService.login('101', 'password');
      
      expect(result, true);
      expect(authService.isAuthenticated, true);
      expect(authService.userName, 'Manas Malla');
      expect(authService.currentUser?.username, '101');
    });

    test('should reject invalid credentials', () async {
      // Test invalid username
      var result = await authService.login('wrong', 'password');
      expect(result, false);
      expect(authService.isAuthenticated, false);

      // Test invalid password
      result = await authService.login('101', 'wrongpassword');
      expect(result, false);
      expect(authService.isAuthenticated, false);
    });

    test('should validate credentials correctly', () {
      expect(authService.validateCredentials('101', 'password'), true);
      expect(authService.validateCredentials('wrong', 'password'), false);
      expect(authService.validateCredentials('101', 'wrong'), false);
    });

    test('should logout successfully', () async {
      // Login first
      await authService.login('101', 'password');
      expect(authService.isAuthenticated, true);
      
      // Then logout
      authService.logout();
      expect(authService.isAuthenticated, false);
      expect(authService.currentUser, null);
    });

    test('should clear auth data successfully', () async {
      // Login first
      await authService.login('101', 'password');
      expect(authService.isAuthenticated, true);
      
      // Clear data
      authService.clearAuthData();
      expect(authService.isAuthenticated, false);
      expect(authService.currentUser, null);
    });
  });

  group('User Model Tests', () {
    test('should create user correctly', () {
      const user = User(
        username: '101',
        name: 'Manas Malla',
        isAuthenticated: true,
      );

      expect(user.username, '101');
      expect(user.name, 'Manas Malla');
      expect(user.isAuthenticated, true);
    });

    test('should serialize to JSON correctly', () {
      const user = User(
        username: '101',
        name: 'Manas Malla',
        isAuthenticated: true,
      );

      final json = user.toJson();
      expect(json['username'], '101');
      expect(json['name'], 'Manas Malla');
      expect(json['isAuthenticated'], true);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'username': '101',
        'name': 'Manas Malla',
        'isAuthenticated': true,
      };

      final user = User.fromJson(json);
      expect(user.username, '101');
      expect(user.name, 'Manas Malla');
      expect(user.isAuthenticated, true);
    });

    test('should copy with changes correctly', () {
      const user = User(
        username: '101',
        name: 'Manas Malla',
        isAuthenticated: false,
      );

      final updatedUser = user.copyWith(isAuthenticated: true);
      expect(updatedUser.username, '101');
      expect(updatedUser.name, 'Manas Malla');
      expect(updatedUser.isAuthenticated, true);
    });
  });
}