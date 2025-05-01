// lib/models/user.dart
class User {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String?
      password; // Not stored in Firestore, only used during registration

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.password,
  });

  // Factory constructor to create a User from a Map (for Firestore)
  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
    );
  }

  // Convert User to a Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }
}
