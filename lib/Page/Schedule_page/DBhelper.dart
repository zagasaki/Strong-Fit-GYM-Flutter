import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseDatabase {
  static final ExerciseDatabase instance = ExerciseDatabase._init();

  static Database? _database;

  ExerciseDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('exercise_database.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE exercises(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        checked INTEGER
      )
      ''');
  }

  Future<int> insertExercise(Map<String, bool> exercises) async {
    final db = await instance.database;
    int count = 0;

    exercises.forEach((name, checked) async {
      final exercise = {
        'name': name,
        'checked': checked ? 1 : 0,
      };

      count += await db.insert('exercises', exercise);
    });

    return count;
  }

  Future<List<Map<String, dynamic>>> getExercises() async {
    final db = await instance.database;
    return await db.query('exercises');
  }
}
