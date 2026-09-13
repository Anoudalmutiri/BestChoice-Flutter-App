import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('bestchoice.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS users');
        await db.execute('DROP TABLE IF EXISTS saved_certifications');
        await _createDB(db, newVersion);
      },
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE users(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,
email TEXT UNIQUE,
password TEXT,
major TEXT,
level TEXT
)
''');

    await db.execute('''
CREATE TABLE saved_certifications(
id INTEGER PRIMARY KEY AUTOINCREMENT,
title TEXT,
provider TEXT,
type TEXT
)
''');
    await db.execute('''
CREATE TABLE certifications(
id INTEGER PRIMARY KEY AUTOINCREMENT,
title TEXT,
provider TEXT,
major TEXT,
level TEXT,
duration TEXT
)
''');
  }
  Future<int> insertUser(UserModel user) async {
    final db = await instance.database;

    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<UserModel?> loginUser(String email, String password) async {
    final db = await instance.database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }

    return null;
  }
  Future<int> insertSavedCertification(
      String title,
      String provider,
      String type,
      ) async {
    final db = await instance.database;

    return await db.insert(
      'saved_certifications',
      {
        'title': title,
        'provider': provider,
        'type': type,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getSavedCertifications() async {
    final db = await instance.database;

    return await db.query('saved_certifications');
  }

  Future<int> deleteSavedCertification(int id) async {
    final db = await instance.database;

    return await db.delete(
      'saved_certifications',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertDefaultCertifications() async {
    final db = await instance.database;

    await db.insert('certifications', {
      'title': 'AWS Cloud Practitioner',
      'provider': 'Amazon',
      'major': 'Information Technology',
      'level': 'Beginner',
      'duration': '20 Hours',
    });

    await db.insert('certifications', {
      'title': 'AZ-900 Azure Fundamentals',
      'provider': 'Microsoft',
      'major': 'Information Technology',
      'level': 'Beginner',
      'duration': '16 Hours',
    });

    await db.insert('certifications', {
      'title': 'Oracle Java Foundations',
      'provider': 'Oracle',
      'major': 'Information Technology',
      'level': 'Intermediate',
      'duration': '30 Hours',
    });

    await db.insert('certifications', {
      'title': 'Google Data Analytics',
      'provider': 'Google',
      'major': 'Data Science',
      'level': 'Beginner',
      'duration': '40 Hours',
    });
  }
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}