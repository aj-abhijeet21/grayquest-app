import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart';

const String tableUsers = 'users';

class UserFields {
  static final String id = '_id';
  static final String username = 'username';
  static final String password = 'password';
}

class Users {
  final int? id;
  final String? username;
  final String? password;

  Users({
    required this.id,
    required this.password,
    required this.username,
  });
  Map<String, Object?> toJson() {
    return {
      UserFields.id: id,
      UserFields.username: username,
      UserFields.password: password,
    };
  }

  static Users fromJson(Map<String, dynamic> map) {
    final id = map[UserFields.id] as int?;
    final username = map[UserFields.username] as String?;
    final password = map[UserFields.password] as String?;
    return Users(id: id, password: password, username: username);
  }
}

class DatabaseManager {
  static const _dbName = 'database.db';

  static final DatabaseManager instance = DatabaseManager._init();

  static Database? _database;

  DatabaseManager._init();

  var users = [
    {
      'username': 'Delphine',
      'password': 'Delphine',
    },
    {
      'username': 'Maxime_Nienow',
      'password': 'Maxime_Nienow',
    },
    {
      'username': 'Elwyn.Skiles',
      'password': 'Elwyn.Skiles',
    },
    {
      'username': 'Leopoldo_Corkery',
      'password': 'Leopoldo_Corkery',
    },
    {
      'username': 'Kamren',
      'password': 'Kamren',
    },
    {
      'username': 'Karianne',
      'password': 'Karianne',
    },
    {
      'username': 'Samantha',
      'password': 'Samantha',
    },
    {
      'username': 'Antonette',
      'password': 'Antonette',
    },
    {
      'username': 'Bret',
      'password': 'Bret',
    },
  ];

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase(_dbName);
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, _dbName);
    // return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future _onCreate(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableUsers (
    ${UserFields.id}  $idType,
    ${UserFields.username} $textType,
    ${UserFields.password} $textType
    )
    ''');

    var batch = db.batch();
    users.forEach(
      (element) {
        batch.insert(tableUsers, element);
      },
    );
    var result = batch.commit();
    print(result);
  }

  Future<bool> authenticateUser(
      String username, String passwordFromUser) async {
    Database database = await instance.database;
    final maps = await database.query(
      tableUsers,
      columns: [UserFields.password],
      where: '${UserFields.username} = ?',
      whereArgs: [username],
    );
    print('select query result $maps');
    String? passwordFromDb = '';

    if (maps.isNotEmpty) {
      passwordFromDb = Users.fromJson(maps.first).password;
    }
    // else {
    //   throw Exception('Username $username not found');
    // }

    if (passwordFromUser == passwordFromDb) {
      return true;
    } else {
      return false;
    }
  }
}
