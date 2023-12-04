import 'dart:async';

import 'package:path/path.dart';
import 'package:projet/models/User.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'food_app.db'),
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE users(
            id TEXT PRIMARY KEY,
            username TEXT,
            password TEXT,
            isAdmin INTEGER
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertUser(User user) async {
    await _database.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUserByUsername(String username) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return User(
        id: maps[0]['id'],
        username: maps[0]['username'],
        password: maps[0]['password'],
        isAdmin: maps[0]['isAdmin'] == 1,
      );
    } else {
      return null;
    }
  }

  Future<List<User>> getAllUsers() async {
    final List<Map<String, dynamic>> maps = await _database.query('users');

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['username'],
        password: maps[i]['password'],
        isAdmin: maps[i]['isAdmin'] == 1,
      );
    });
  }
}
