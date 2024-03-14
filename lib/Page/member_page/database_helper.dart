import 'package:basic/Page/member_page/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  final String databaseName = 'membership.db';
  final int databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE memberships(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      currentStatus TEXT,  
      startDate TEXT,
      endDate TEXT         
    )
  ''');
  }

  Future<int> insertMembership(MembershipDetailModel membership) async {
    final Database db = await database;
    return await db.insert('memberships', membership.toMap());
  }

  Future<List<MembershipDetailModel>> getMemberships() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('memberships');
    return List.generate(maps.length, (index) {
      return MembershipDetailModel.fromMap(maps[index]);
    });
  }
}
