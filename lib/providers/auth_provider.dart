import 'package:flutter/material.dart';
import 'package:customerapp_chillfix/models/user.dart'; // Add this import

class AuthProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}