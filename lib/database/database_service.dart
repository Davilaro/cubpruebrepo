import 'dart:async';
import 'dart:ffi';

import 'package:coopi_app/database/database.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../features/login/data/models/user.dart';

class DatabaseService {

  final User? userData;

  DatabaseService({this.userData});
  
  Future<Database> _database() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await AppDatabase().database;
  }

  Future<void> insertUser() async {
    final db = await _database();

    await db.insert(
      'users',
      userData!.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
    // print('userData: $userData');

    // await insertUser(userData as User);

    // get users
  Future<List<User>> getUsers() async {

    final db = await _database();

    final List<Map<String, Object?>> userMaps = await db.query('users');

    return [
      for ( final {
        'id': id as int,
        'username': username as String,
        'password': password as String,
        'token': token as String,
        'role': role as String,
        'createdAt': createdAt as String,
        'updatedAt': updatedAt as String,
      } in userMaps)
      User(updatedAt,
        id: id,
        username: username,
        password: password,
        token: token,
        role: role,
        createdAt: createdAt
      ),
    ];
  }

  Future<void> deleteAllUsers() async {

    final db = await _database();

    await db.rawDelete("DELETE FROM users");
  }
  
}