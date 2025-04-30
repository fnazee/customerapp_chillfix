// lib/screens/service_list_screen.dart
import 'package:flutter/material.dart';
import 'package:customerapp_chillfix/screens/provider_profile_screen.dart';

class ServiceListScreen extends StatelessWidget {
  final String category;

  const ServiceListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Providers'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual provider count
        itemBuilder: (context, index) {
          return _buildProviderCard(context, index);
        },
      ),
    );
  }

  Widget _buildProviderCard(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/men/${index + 10}.jpg'),
        ),
        title: Text('Provider ${index + 1}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                Text(' 4.8 (120 reviews)'),
              ],
            ),
            const Text('200+ jobs completed'),
            Text('\$25/hour', style: TextStyle(color: Colors.green[700])),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProviderProfileScreen(providerId: index + 1),
            ),
          );
        },
      ),
    );
  }
}