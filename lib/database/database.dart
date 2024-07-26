import 'dart:async';
import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user.dart';

import 'migrations/migration_v1.dart';
import 'migrations/migration_v2.dart';

class AppDatabase {

  static final AppDatabase _instance = AppDatabase._();
  static Database? _database;

  AppDatabase._();

  factory AppDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initializeDatabase('coopi_app.db');
    return _database!;
  }
  
  Future<Database> _initializeDatabase(String filePath) async {
    String dbPath = join(await getDatabasesPath(), filePath);

    return await openDatabase(
      dbPath,
      version: 2,
      onCreate:(db, version) async {
        await db.execute(MigrationV1.createTable);
        await db.execute(MigrationV2.migrationScript);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(MigrationV2.migrationScript);
        }
      }
    );
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}