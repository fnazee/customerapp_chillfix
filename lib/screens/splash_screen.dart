import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customerapp_chillfix/providers/auth_provider.dart';
import 'package:customerapp_chillfix/screens/home_screen.dart';
import 'package:customerapp_chillfix/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use a post-frame callback to ensure the widget is fully built
    // before calling any provider methods
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserStatus();
    });
  }

  Future<void> _checkUserStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isLoggedIn = await authProvider.isUserLoggedIn();

    if (mounted) {
      // Navigate to appropriate screen based on auth status
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              isLoggedIn ? const HomeScreen() : const WelcomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // You can add your app logo here
            Image.asset(
              'assets/icons/chillfix_logo.png',
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
