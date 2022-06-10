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

  puzzleDao? _puzzledaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `carboEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dataString` TEXT NOT NULL, `fitbitSteps` REAL, `fitbitCals` REAL, `value` REAL, `carbBurned` REAL, `lastTimeRefreshed` INTEGER, `lastLimitRefresher` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `puzzleEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dataString` TEXT NOT NULL, `numPuzzle` INTEGER, `numPezzo` INTEGER, `alreadyClicked` INTEGER, FOREIGN KEY (`id`) REFERENCES `carboEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  carboDao get carbodao {
    return _carbodaoInstance ??= _$carboDao(database, changeListener);
  }

  @override
  puzzleDao get puzzledao {
    return _puzzledaoInstance ??= _$puzzleDao(database, changeListener);
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
                  'carbBurned': item.carbBurned,
                  'lastTimeRefreshed': item.lastTimeRefreshed,
                  'lastLimitRefresher': item.lastLimitRefresher
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<carboEntity> _carboEntityInsertionAdapter;

  @override
  Future<List<carboEntity?>> show_data() async {
    return _queryAdapter.queryList('SELECT * FROM carboEntity',
        mapper: (Map<String, Object?> row) => carboEntity(
            row['id'] as int?,
            row['dataString'] as String,
            row['fitbitSteps'] as double?,
            row['fitbitCals'] as double?,
            row['value'] as double?,
            row['carbBurned'] as double?,
            row['lastTimeRefreshed'] as int?,
            row['lastLimitRefresher'] as int?));
  }

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
            row['carbBurned'] as double?,
            row['lastTimeRefreshed'] as int?,
            row['lastLimitRefresher'] as int?),
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
            row['carbBurned'] as double?,
            row['lastTimeRefreshed'] as int?,
            row['lastLimitRefresher'] as int?),
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
  Future<void> update_lastTimeRefreshed(
      int lastTimeRefreshed, String dataString) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE carboEntity SET lastTimeRefreshed = ?1 WHERE dataString = ?2',
        arguments: [lastTimeRefreshed, dataString]);
  }

  @override
  Future<void> update_lastLimitRefresher(
      int lastLimitRefresher, String dataString) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE carboEntity SET lastLimitRefresher = ?1 WHERE dataString = ?2',
        arguments: [lastLimitRefresher, dataString]);
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

class _$puzzleDao extends puzzleDao {
  _$puzzleDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _puzzleEntityInsertionAdapter = InsertionAdapter(
            database,
            'puzzleEntity',
            (puzzleEntity item) => <String, Object?>{
                  'id': item.id,
                  'dataString': item.dataString,
                  'numPuzzle': item.numPuzzle,
                  'numPezzo': item.numPezzo,
                  'alreadyClicked': item.alreadyClicked == null
                      ? null
                      : (item.alreadyClicked! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<puzzleEntity> _puzzleEntityInsertionAdapter;

  @override
  Future<puzzleEntity?> check_puzzleEntity(String dataString) async {
    return _queryAdapter.query(
        'SELECT * FROM puzzleEntity WHERE dataString = ?1',
        mapper: (Map<String, Object?> row) => puzzleEntity(
            row['id'] as int?,
            row['dataString'] as String,
            row['numPuzzle'] as int?,
            row['numPezzo'] as int?,
            row['alreadyClicked'] == null
                ? null
                : (row['alreadyClicked'] as int) != 0),
        arguments: [dataString]);
  }

  @override
  Future<puzzleEntity?> check_puzzleEntity_id(int id) async {
    return _queryAdapter.query('SELECT * FROM puzzleEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => puzzleEntity(
            row['id'] as int?,
            row['dataString'] as String,
            row['numPuzzle'] as int?,
            row['numPezzo'] as int?,
            row['alreadyClicked'] == null
                ? null
                : (row['alreadyClicked'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> update_numPuzzle(int numPuzzle, String dataString) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE puzzleEntity SET numPuzzle = ?1 WHERE dataString = ?2',
        arguments: [numPuzzle, dataString]);
  }

  @override
  Future<void> update_numPezzo(int numPezzo, String dataString) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE puzzleEntity SET numPezzo = ?1 WHERE dataString = ?2',
        arguments: [numPezzo, dataString]);
  }

  @override
  Future<void> update_alreadyClicked(
      bool alreadyClicked, String dataString) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE puzzleEntity SET alreadyClicked = ?1 WHERE dataString = ?2',
        arguments: [alreadyClicked ? 1 : 0, dataString]);
  }

  @override
  Future<void> delete_all_puzzle() async {
    await _queryAdapter.queryNoReturn('DELETE FROM puzzleEntity');
  }

  @override
  Future<void> insert_puzzleEntity(puzzleEntity puzzleentity) async {
    await _puzzleEntityInsertionAdapter.insert(
        puzzleentity, OnConflictStrategy.abort);
  }
}
