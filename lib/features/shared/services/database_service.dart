import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// TODO: Create a stub for testing

/// Record of all table names within the current database.
typedef DatabaseTableNames = ({String entires, String likedQuotes, String images});

/// Responsible for:
/// - database initialization, creation, and migration
/// - providing an instance of the database
/// - database opening and closing
class DatabaseService extends ChangeNotifier {
  late Database _db;

  /// Current database version number.
  final int _databaseVersionNumber = 5;

  Database get db => _db;

  static const _databaseName = 'Journal_App_Data';

  final DatabaseTableNames _table = (
    entires: "Entries",
    likedQuotes: "LikedQutes ",
    images: "Images",
  );

  DatabaseTableNames get table => _table;

  Future<void> initialize() async {
    final String path = await _getPath(_databaseName);

    _db = await _openDatabase(_databaseVersionNumber, path);

    await _getCurrentSchemaInformation(db);

    debugPrint("database opened successfully.");
  }

  Future<Database> _openDatabase(int version, String path) async {
    return openDatabase(
      version: version,
      path,
      onCreate: _createDatabase,
      onUpgrade: _migrateDatabase,
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
  }

  Future<void> _configureDatabase(Database db) async {
    // turn on the use of foreign key constraints | required configuration to use foreign keys
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _migrateDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion == _databaseVersionNumber - 1) {
      await _createImagesTable(db);
    }
  }

  Future<void> _createEntriesTable(Database db) async {
    await db.execute('DROP TABLE IF EXISTS ${table.entires}');

    await db.execute(
      '''CREATE TABLE 
          ${_table.entires} (
            ${DataType.primaryKey.name},
            content ${DataType.string.name},
            mood_type ${DataType.string.name},
            created_at ${DataType.string.name},
            updated_at ${DataType.string.name}
            )''',
    );
  }

  Future<void> _createLikedQuotesTable(Database db) async {
    await db.execute('DROP TABLE IF EXISTS ${table.likedQuotes}');

    await db.execute(
      '''CREATE TABLE 
          ${_table.likedQuotes} (
            ${DataType.primaryKey.name},
            author ${DataType.string.name},
            quote ${DataType.string.name},
            is_liked ${DataType.string.name},
            created_at ${DataType.string.name}
            )''',
    );
  }

  Future<void> _createImagesTable(Database db) async {
    await db.execute('DROP TABLE IF EXISTS ${table.images}');

    await db.execute('''CREATE TABLE
          ${_table.images} (
            ${DataType.primaryKey.name},
            entry_id ${DataType.integer.name},
            image_name ${DataType.string.name},
            FOREIGN KEY (entry_id) REFERENCES Entries(id) ON DELETE CASCADE
          )
''');
  }
}

enum DataType {
  integer('INTEGER'),
  string('TEXT'),
  blob('BLOB'),
  real('REAL'),
  numeric('NUMERIC'),
  date('DATE'),
  time('TIME'),
  datetime('DATETIME'),
  primaryKey('id INTEGER PRIMARY KEY AUTOINCREMENT');

  final String name;

  const DataType(this.name);
}
