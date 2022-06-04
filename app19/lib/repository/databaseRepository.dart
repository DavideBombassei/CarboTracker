import 'package:app19/database/database.dart';
import 'package:app19/database/entities/carboEntity.dart';
import 'package:flutter/material.dart';

class DatabaseRepository extends ChangeNotifier{

  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  //This method wraps the method of the DAO
  Future<carboEntity?> check_carboEntity(String dataString) async{
    final results = await database.carbodao.check_carboEntity(dataString);
    return results;
  }

  Future<int?> get_todayId(String dataString) async{
    final results = await database.carbodao.get_todayId(dataString);
    return results;
  }

  Future<double?> get_value(int id) async{
    final results = await database.carbodao.get_value(id);
    return results;
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

  //This method wraps the insert() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> insert_carboEntity(carboEntity carboentity) async {
    await database.carbodao.insert_carboEntity(carboentity);
    notifyListeners();
  }
  
}//DatabaseRepository