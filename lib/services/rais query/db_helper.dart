import 'package:food_app/functionalities/profile/help%20&%20support/model/query_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const String tableName = 'queries';
  static const String dbName = 'queries.db';

  static Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $tableName(
        ticketId TEXT PRIMARY KEY,
        userId TEXT,
        query TEXT,
        dateTime TEXT
        )
        ''');
      },
    );
  }

  static Future<int> insertQuery(QueryModel query) async {
    final db = await getDatabase();
    return await db.insert(
      tableName,
      query.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<QueryModel>> getQueries() async {
    final db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps.map((map) => QueryModel.fromJson(map)).toList();
  }

  static Future<int> deleteQuery(String ticketId) async {
    final db = await getDatabase();
    return await db.delete(
      tableName,
      where: 'ticketId = ?',
      whereArgs: [ticketId],
    );
  }

  static Future<int> updateQuery(QueryModel query) async {
    final db = await getDatabase();

    return await db.update(
      tableName,
      query.toJson(),
      where: 'ticketId = ?',
      whereArgs: [query.ticketId],
    );
  }
}
