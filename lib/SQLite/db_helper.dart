import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import '../JsonModels/users.dart';

class Event {
  int? id;
  String name;
  TimeOfDay time;
  DateTime date;

  Event({this.id, required this.name, required this.time, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'hour': time.hour,
      'minute': time.minute,
      'date': date.toIso8601String(),
    };
  }

  static Event fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      name: map['name'],
      time: TimeOfDay(hour: map['hour'], minute: map['minute']),
      date: DateTime.parse(map['date']),
    );
  }

  int compareTo(Event other) {
    final thisTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    final otherTime = DateTime(other.date.year, other.date.month, other.date.day, other.time.hour, other.time.minute);
    return thisTime.compareTo(otherTime);
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(userTable);
        await db.execute(eventTable);
      },
    );
  }

  String userTable = '''
    CREATE TABLE users (
    usrId INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL,
    usrName TEXT UNIQUE NOT NULL,
    usrPassword TEXT NOT NULL
    )
  ''';

  String eventTable = '''
    CREATE TABLE events(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        hour INTEGER,
        minute INTEGER,
        date TEXT
    )
  ''';

  Future<bool> authenticate(Users usr) async {
    final Database db = await database;
    var result = await db.rawQuery(
        "SELECT * FROM users WHERE usrName = ? AND usrPassword = ?",
        [usr.usrName, usr.password]);
    return result.isNotEmpty;
  }

  Future<int> createUser(Users usr) async {
    final Database db = await database;
    return db.insert("users", usr.toMap());
  }

  Future<Users?> getUser(String usrName) async {
    final Database db = await database;
    var res = await db.query("users", where: "usrName = ?", whereArgs: [usrName]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }

  Future<void> insertEvent(Event event) async {
    final db = await database;
    await db.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Event>> fetchEventsByDate(DateTime date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'events',
      where: 'date = ?',
      whereArgs: [date.toIso8601String()],
    );
    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }

  Future<void> updateEvent(Event event) async {
    final db = await database;
    await db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<void> deleteEvent(int id) async {
    final db = await database;
    await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import '../JsonModels/users.dart';

// class DatabaseHelper {
//   final databaseName = "auth.db";

//   String userTable = '''
//     CREATE TABLE users (
//     usrId INTEGER PRIMARY KEY AUTOINCREMENT,
//     email TEXT NOT NULL,
//     usrName TEXT UNIQUE NOT NULL,
//     usrPassword TEXT NOT NULL
//     )
//   ''';

//   Future<Database> initDB() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, databaseName);

//     return openDatabase(path, version: 1, onCreate: (db, version) async {
//       await db.execute(userTable);
//     });
//   }

//   Future<bool> authenticate(Users usr) async {
//     final Database db = await initDB();
//     var result = await db.rawQuery(
//         "SELECT * FROM users WHERE usrName = ? AND usrPassword = ?",
//         [usr.usrName, usr.password]);
//     return result.isNotEmpty;
//   }

//   Future<int> createUser(Users usr) async {
//     final Database db = await initDB();
//     return db.insert("users", usr.toMap());
//   }

//   Future<Users?> getUser(String usrName) async {
//     final Database db = await initDB();
//     var res = await db.query("users", where: "usrName = ?", whereArgs: [usrName]);
//     return res.isNotEmpty ? Users.fromMap(res.first) : null;
//   }
// }