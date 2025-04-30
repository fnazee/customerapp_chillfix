// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:customerapp_chillfix/screens/service_list_screen.dart';
import 'package:customerapp_chillfix/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChillFix'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SearchBar(
              hintText: 'Search for services...',
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildCategoryCard(
                    context,
                    'Plumbing',
                    Icons.plumbing,
                    Colors.blue,
                  ),
                  _buildCategoryCard(
                    context,
                    'Electrical',
                    Icons.electrical_services,
                    Colors.amber,
                  ),
                  _buildCategoryCard(
                    context,
                    'Cleaning',
                    Icons.cleaning_services,
                    Colors.green,
                  ),
                  _buildCategoryCard(
                    context,
                    'Carpentry',
                    Icons.carpenter,
                    Colors.brown,
                  ),
                  _buildCategoryCard(
                    context,
                    'Appliance Repair',
                    Icons.build_circle_outlined,
                    Colors.deepPurple,
                  ),
                  _buildCategoryCard(
                    context,
                    'Other',
                    Icons.more_horiz,
                    Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceListScreen(category: title),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
