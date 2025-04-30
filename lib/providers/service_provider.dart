import 'package:flutter/material.dart';

class ServiceProvider extends ChangeNotifier {
  // Add your service-related state management here
  // Example:
  List<String> _services = [];

  List<String> get services => _services;

  void addService(String service) {
    _services.add(service);
    notifyListeners();
  }
}