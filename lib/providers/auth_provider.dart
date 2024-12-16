import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_controller.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String _role = '';
  User? _user;

  bool get isAuthenticated => _isAuthenticated;
  String get role => _role;
  User? get user => _user;

  AuthProvider() {
    _loadAuthStatus();
  }

  void _loadAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    final token = prefs.getString('accessToken') ?? '';
    if (token.isNotEmpty && !JwtDecoder.isExpired(token)) {
      final decodedToken = JwtDecoder.decode(token);
      _role = decodedToken['role'] ?? '';
      await _fetchUserInfo();
    } else {
      _isAuthenticated = false;
      _role = '';
    }
    notifyListeners();
  }

  void login(String role) async {
    _isAuthenticated = true;
    _role = role;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAuthenticated', true);
    await _fetchUserInfo();
    notifyListeners();
  }

  void logout() async {
    _isAuthenticated = false;
    _role = '';
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    final authController = AuthController();
    await authController.logoutUser();
    prefs.setBool('isAuthenticated', false);
    prefs.remove('accessToken');
    notifyListeners();
  }

  Future<void> _fetchUserInfo() async {
    final authController = AuthController();
    _user = await authController.getUserInfo();
    notifyListeners();
  }

  Future<void> updateProfile(String name, String phone, String email) async {
    final authController = AuthController();
    await authController.updateProfile(name, phone, email);
    await _fetchUserInfo();
  }
}
