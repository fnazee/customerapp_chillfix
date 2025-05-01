// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerapp_chillfix/models/user.dart';

class AuthProvider extends ChangeNotifier {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _auth.currentUser != null;

  // Register with email and password
  Future<bool> registerUser(User user) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Create user in Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      );

      // Save additional user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': user.name,
        'email': user.email,
        'phone': user.phone,
        'address': user.address,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'role': 'customer', // Specify that this is a customer account
      });

      // Set current user
      _currentUser = User(
        id: userCredential.user!.uid,
        name: user.name,
        email: user.email,
        phone: user.phone,
        address: user.address,
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = _handleAuthError(e);
      notifyListeners();
      return false;
    }
  }

  // Sign in with email and password
  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Sign in user with Firebase Auth
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user data from Firestore
      final userData = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userData.exists) {
        _currentUser = User(
          id: userCredential.user!.uid,
          name: userData['name'],
          email: userData['email'],
          phone: userData['phone'],
          address: userData['address'],
        );
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = _handleAuthError(e);
      notifyListeners();
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }

  // Safely check if user is already signed in without notifying listeners
  Future<bool> isUserLoggedIn() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final userData =
            await _firestore.collection('users').doc(user.uid).get();
        if (userData.exists) {
          _currentUser = User(
            id: user.uid,
            name: userData['name'] ?? '',
            email: userData['email'] ?? '',
            phone: userData['phone'] ?? '',
            address: userData['address'] ?? '',
          );
          return true;
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
    return false;
  }

  // Check current user and notify listeners - only call this when not in build phase
  Future<void> checkCurrentUser() async {
    final isLoggedIn = await isUserLoggedIn();
    // Only notify listeners if we're not in the build phase
    notifyListeners();
  }

  // Helper method to handle Firebase Auth errors
  String _handleAuthError(dynamic e) {
    if (e is firebase_auth.FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'This email is already registered';
        case 'invalid-email':
          return 'The email address is invalid';
        case 'operation-not-allowed':
          return 'Email/password accounts are not enabled';
        case 'weak-password':
          return 'The password is too weak';
        case 'wrong-password':
          return 'Incorrect password';
        case 'user-not-found':
          return 'No user found with this email';
        case 'user-disabled':
          return 'This account has been disabled';
        default:
          return 'An error occurred: ${e.message}';
      }
    }
    return 'An unexpected error occurred';
  }
}
