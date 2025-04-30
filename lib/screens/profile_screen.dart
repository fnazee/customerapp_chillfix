import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customerapp_chillfix/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: user != null
            ? [
              Text('Name: ${user.name ?? "Not set"}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Email: ${user.email ?? "Not set"}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Phone: ${user.phone ?? "Not set"}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Address: ${user.address ?? "Not set"}', style: const TextStyle(fontSize: 18)),
            ]
          : [const Text('No user data found'),
            ],
        ),
      ),
    );
  }
}