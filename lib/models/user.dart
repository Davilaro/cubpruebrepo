import 'package:flutter/rendering.dart';

class User {

  final int id;
  final String username;
  final String password;
  final String token;
  final String role;

  final String createdAt;
  final String updatedAt;

  User(
    this.updatedAt,
    {
      required this.id,
      required this.username,
      required this.password,
      required this.token,
      required this.role,
      required this.createdAt,
    }
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'token': token,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password, token: $token, role: $role}';
  }
}