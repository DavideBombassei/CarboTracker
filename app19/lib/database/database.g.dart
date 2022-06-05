// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  carboDao? _carbodaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `carboEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dataString` TEXT NOT NULL, `fitbitSteps` REAL, `fitbitCals` REAL, `value` REAL, `carbBurned` REAL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  carboDao get carbodao {
    return _carbodaoInstance ??= _$carboDao(database, changeListener);
  }
}

class _$carboDao extends carboDao {
  _$carboDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _carboEntityInsertionAdapter = InsertionAdapter(
            database,
            'carboEntity',
            (carboEntity item) => <String, Object?>{
                  'id': item.id,
                  'dataString': item.dataString,
                  'fitbitSteps': item.fitbitSteps,
                  'fitbitCals': item.fitbitCals,
                  'value': item.value,
                  'carbBurned': item.carbBurned
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<carboEntity> _carboEntityInsertionAdapter;

  @override
  Future<carboEntity?> check_carboEntity(String dataString) async {
    return _queryAdapter.query(
        'SELECT * FROM carboEntity WHERE dataString = ?1',
        mapper: (Map<String, Object?> row) => carboEntity(
            row['id'] as int?,
            row['dataString'] as String,
            row['fitbitSteps'] as double?,
            row['fitbitCals'] as double?,
            row['value'] as double?,
            row['carbBurned'] as double?),
        arguments: [dataString]);
  }

  @override
  Future<carboEntity?> check_carboEntity_id(int id) async {
    return _queryAdapter.query('SELECT * FROM carboEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => carboEntity(
            row['id'] as int?,
            row['dataString'] as String,
            row['fitbitSteps'] as double?,
            row['fitbitCals'] as double?,
            row['value'] as double?,
            row['carbBurned'] as double?),
        arguments: [id]);
  }

  @override
  Future<void> update_fitbitSteps(double fitbitSteps, String dataString) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE carboEntity SET fitbitSteps = ?1 WHERE dataString = ?2',
        arguments: [fitbitSteps, dataString]);
  }

  @override
  Future<void> update_fitbitCals(double fitbitCals, String dataString) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE carboEntity SET fitbitCals = ?1 WHERE dataString = ?2',
        arguments: [fitbitCals, dataString]);
  }

  @override
  Future<void> update_value(double value, int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE carboEntity SET value = ?1 WHERE id = ?2',
        arguments: [value, id]);
  }

  @override
  Future<void> update_carbBurned(double carbBurned, String dataString) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE carboEntity SET carbBurned = ?1 WHERE dataString = ?2',
        arguments: [carbBurned, dataString]);
  }

  @override
  Future<void> delete_all() async {
    await _queryAdapter.queryNoReturn('DELETE FROM carboEntity');
  }

  @override
  Future<void> insert_carboEntity(carboEntity carboentity) async {
    await _carboEntityInsertionAdapter.insert(
        carboentity, OnConflictStrategy.abort);
  }
}
