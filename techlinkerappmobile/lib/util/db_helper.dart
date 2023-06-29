import 'package:techlinkerappmobile/models/accept_terms.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 1;
  Database? db;

  static final DbHelper _dbHelper = DbHelper._internal();
  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(
        join(await getDatabasesPath(), 'techlinker.db'),
        onCreate: (database, version) {
          database.execute(
            'CREATE TABLE accept_terms(id INTEGER PRIMARY KEY, isAccepted INTEGER)',
          );
        },
        version: version,
      );
    }
    return db!;
  }

  Future<int> insertAcceptTerms(AcceptTerms acceptTerms) async {
    int id = await this.db!.insert(
          'accept_terms',
          acceptTerms.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return id;
  }

  Future<AcceptTerms> getAcceptTerms(int id) async {
    List<Map<String, dynamic>> maps = await db!.query(
      'accept_terms',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return AcceptTerms.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> deleteAcceptTerms(int id) async {
    return await db!.delete(
      'accept_terms',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateAcceptTerms(AcceptTerms acceptTerms) async {
    return await db!.update(
      'accept_terms',
      acceptTerms.toJson(),
      where: 'id = ?',
      whereArgs: [acceptTerms.id],
    );
  }

  Future<bool> isAccepted(AcceptTerms acceptTerms) async {
    final Database db = await openDb();
    List<Map<String, dynamic>> maps = await db!.query(
      'accept_terms',
      where: 'id = ?',
      whereArgs: [acceptTerms.id],
      
    );
    return maps.length > 0;
  }

}