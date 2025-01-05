import 'dart:math'; // Import for random number generation
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviewer/boxes/user.dart';

class AuthService {
  static const String _boxName = 'users';

  Future<void> init() async {
    await Hive.openBox<User>(_boxName);
  }

  Future<User?> register(String username, String email, String password) async {
    final box = Hive.box<User>(_boxName);

    final existingUser =
        box.values.where((user) => user.email == email).toList();
    if (existingUser.isNotEmpty) {
      throw Exception('User already exists');
    }

    // Generate a random int for the ID
    final newUser = User(
      id: _generateUniqueId(box),
      username: username,
      email: email,
      password: password,
    );

    await box.add(newUser);
    return newUser;
  }

  Future<User?> login(String email, String password) async {
    final box = Hive.box<User>(_boxName);

    try {
      final user = box.values.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      return user;
    } catch (e) {
      // Return null if no user is found
      return null;
    }
  }

  Future<void> logout() async {
    //clear some session data here in a real app
  }

  int _generateUniqueId(Box<User> box) {
    // Generate a unique ID by incrementing the current highest ID in the box
    final ids = box.values.map((user) => user.id).toList();
    return (ids.isNotEmpty ? ids.reduce(max) + 1 : 1);
  }
}
