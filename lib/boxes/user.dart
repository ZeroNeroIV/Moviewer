import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String password;

  @HiveField(3)
  String email;
}
