import 'package:path/path.dart';
import 'package:pokeapi_test/database/operation.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'pokeapi_test.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      onCreate: (database, version) async => await Operation().createTable(database),
      version: 1,
      singleInstance: true,
    );
    return database;
  }

  // Future<void> create(Database database, int version) async =>
  //   await Operation().createTable(database);

  Future<void> deleteDatabase(String path) =>
    databaseFactory.deleteDatabase(path);
}