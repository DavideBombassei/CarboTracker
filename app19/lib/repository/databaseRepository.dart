import 'package:app19/database/database.dart';
import 'package:app19/database/entities/carboEntity.dart';
import 'package:app19/database/entities/puzzleEntity.dart';
import 'package:flutter/material.dart';

class DatabaseRepository extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  Future<List<carboEntity?>> show_data() async {
    final results = await database.carbodao.show_data();
    return results;
  }

  //This method wraps the method of the DAO
  Future<carboEntity?> check_carboEntity(String dataString) async {
    final results = await database.carbodao.check_carboEntity(dataString);
    return results;
  }

  Future<int?> get_id(String dataString) async {
    final results = await database.carbodao.check_carboEntity(dataString);
    return results?.id;
  }

  Future<double?> get_value(int id) async {
    final results = await database.carbodao.check_carboEntity_id(id);
    return results?.value;
  }

  Future<double?> get_fitbitSteps(String dataString) async {
    final results = await database.carbodao.check_carboEntity(dataString);
    return results?.fitbitSteps;
  }

  Future<double?> get_fitbitCals(String dataString) async {
    final results = await database.carbodao.check_carboEntity(dataString);
    return results?.fitbitCals;
  }

  Future<double?> get_carbBurned(String dataString) async {
    final results = await database.carbodao.check_carboEntity(dataString);
    return results?.carbBurned;
  }

  Future<int?> get_lastTimeRefreshed(String dataString) async {
    final results = await database.carbodao.check_carboEntity(dataString);
    return results?.lastTimeRefreshed;
  }

  Future<int?> get_lastLimitRefresher(String dataString) async {
    final results = await database.carbodao.check_carboEntity(dataString);
    return results?.lastLimitRefresher;
  }

  Future<void> update_fitbitSteps(double fitbitSteps, String dataString) async {
    await database.carbodao.update_fitbitSteps(fitbitSteps, dataString);
    notifyListeners();
  }

  Future<void> update_fitbitCals(double fitbitCals, String dataString) async {
    await database.carbodao.update_fitbitCals(fitbitCals, dataString);
    notifyListeners();
  }

  Future<void> update_value(double value, int id) async {
    await database.carbodao.update_value(value, id);
    notifyListeners();
  }

  Future<void> update_carbBurned(double carbBurned, String dataString) async {
    await database.carbodao.update_carbBurned(carbBurned, dataString);
    notifyListeners();
  }

  Future<void> update_lastTimeRefreshed(
      int lastTimeRefreshed, String dataString) async {
    await database.carbodao
        .update_lastTimeRefreshed(lastTimeRefreshed, dataString);
    notifyListeners();
  }

  Future<void> update_lastLimitRefresher(
      int lastLimitRefresher, String dataString) async {
    await database.carbodao
        .update_lastLimitRefresher(lastLimitRefresher, dataString);
    notifyListeners();
  }

  Future<void> delete_all() async {
    await database.carbodao.delete_all();
    notifyListeners();
  }

  //This method wraps the insert() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insert_carboEntity(carboEntity carboentity) async {
    await database.carbodao.insert_carboEntity(carboentity);
    notifyListeners();
  }

  Future<puzzleEntity?> check_puzzleEntity(String dataString) async {
    final results = await database.puzzledao.check_puzzleEntity(dataString);
    return results;
  }

  Future<int?> get_id_puzzle(String dataString) async {
    final results = await database.puzzledao.check_puzzleEntity(dataString);
    return results?.id;
  }

  Future<int?> get_numPuzzle(int id) async {
    final results = await database.puzzledao.check_puzzleEntity_id(id - 1);
    return results?.numPuzzle;
  }

  Future<int?> get_numPezzo(int id) async {
    final results = await database.puzzledao.check_puzzleEntity_id(id - 1);
    return results?.numPezzo;
  }

  Future<bool?> get_alreadyClicked(String dataString) async {
    final results = await database.puzzledao.check_puzzleEntity(dataString);
    return results?.alreadyClicked;
  }

  Future<void> update_numPuzzle(int numPuzzle, String dataString) async {
    await database.puzzledao.update_numPuzzle(numPuzzle, dataString);
    notifyListeners();
  }

  Future<void> update_numPezzo(int numPezzo, String dataString) async {
    await database.puzzledao.update_numPezzo(numPezzo, dataString);
    notifyListeners();
  }

  Future<void> update_alreadyClicked(
      bool alreadyClicked, String dataString) async {
    await database.puzzledao.update_alreadyClicked(alreadyClicked, dataString);
    notifyListeners();
  }

  Future<void> insert_puzzleEntity(puzzleEntity puzzleentity) async {
    await database.puzzledao.insert_puzzleEntity(puzzleentity);
    notifyListeners();
  }
} //DatabaseRepository
