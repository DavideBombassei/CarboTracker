import 'package:app19/database/entities/carboEntity.dart';
import 'package:floor/floor.dart';

@dao
abstract class carboDao {

  @Query('SELECT * FROM carboEntity WHERE dataString = :dataString')
  Future<carboEntity?> check_carboEntity(String dataString);

  @Query('SELECT id FROM carboEntity WHERE dataString = :dataString')
  Future<int?> get_todayId(String dataString);

  @Query('SELECT value FROM carboEntity WHERE id = :id')
  Future<double?> get_value(int id); 

  @Query('UPDATE carboEntity SET fitbitSteps = :fitbitSteps WHERE dataString = :dataString')
  Future<void> update_fitbitSteps(double fitbitSteps, String dataString);

  @Query('UPDATE carboEntity SET fitbitCals = :fitbitCals WHERE dataString = :dataString')
  Future<void> update_fitbitCals(double fitbitCals, String dataString);

  @Query('UPDATE carboEntity SET value = :value WHERE id = :id')
  Future<void> update_value(double value, int id);

  @insert
  Future<void> insert_carboEntity(carboEntity carboentity);

}