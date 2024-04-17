import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Responsible for:
/// - database initialization, creation, and migration
/// - providing an instance of the database
/// - database opening and closing
class DatabaseService extends ChangeNotifier {
  late Database _db;
  Database get db => _db;

  static const _databaseName = 'Journal_App_Data';

  final ({String entires, String likedQuotes}) _table = (entires: "Entries", likedQuotes: "LikedQutes ");

  ({String entires, String likedQuotes}) get table => _table;

  Future<void> initialize() async {
    final String path = await _getPath(_databaseName);

    _db = await _openDatabase(1, path);

    await _getCurrentSchemaInformation(db);

    debugPrint("database opened successfully.");
  }

  Future<Database> _openDatabase(int version, String path) async {
    return openDatabase(
      version: version, // latest version 1
      path,
      onCreate: _createDatabase,
      // onUpgrade: _migrateDatabase,
      onConfigure: _configureDatabase,
    );
  }

  Future<void> closeDatabase() async {
    await db.close();
    debugPrint("database closed successfully.");
  }

  Future<void> _createDatabase(Database db, int version) async {
    await _createEntriesTable(db);

    await _createLikedQuotesTable(db);
  }

  Future<String> _getPath(String databaseName) async {
    // retrieve platform specific directory on the filesystem where the database file will be saved
    final directory = await getApplicationDocumentsDirectory();

    // concatenate directory path and database name with platform specific separator
    final path = join(directory.path, databaseName);

    return path;
  }

  Future<void> _getCurrentSchemaInformation(Database db) async {
    final currentSchema = [
      ...await db.query('sqlite_master', columns: ['sql'])
    ];

    currentSchema.removeWhere((Map result) => result['sql'] == 'CREATE TABLE sqlite_sequence(name,seq)');

    debugPrint('Current Schema:\n');
    for (int i = 0; i < currentSchema.length; i++) {
      debugPrint('${currentSchema[i]['sql']}\n');
    }

    // ! TODO: Remove, for testing purposes only

    // await db.insert(
    //   table.entires,
    //   JournalEntry(
    //     content: 'Begin, to begin is half the work let half still remain, again begin this and though wilt have finished.',
    //     moodType: 'Okay',
    //     createdAt: DateTime.now(),
    //     updatedAt: DateTime.now(),
    //   ).toJSON(),
    // );
  }

  Future<void> _configureDatabase(Database db) async {
    // turn on the use of foreign key constraints | required configuration to use foreign keys
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _migrateDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion == 2) {
      // TODO: implement when you need to migreate the database
    }
  }

  Future<void> _createEntriesTable(Database db) async {
    await db.execute('DROP TABLE IF EXISTS ${_table.entires}');

    await db.execute(
      '''CREATE TABLE 
          ${_table.entires} (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT,
            mood_type TEXT,
            created_at TEXT,
            updated_at TEXT
            )''',
    );
  }

  Future<void> _createLikedQuotesTable(Database db) async {
    await db.execute('DROP TABLE IF EXISTS ${_table.likedQuotes}');

    await db.execute(
      '''CREATE TABLE 
          ${_table.likedQuotes} (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            author TEXT,
            quote TEXT,
            is_liked TEXT,
            created_at TEXT
            )''',
    );
  }
}
