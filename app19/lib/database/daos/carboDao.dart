import 'package:app19/database/entities/carboEntity.dart';
import 'package:floor/floor.dart';

@dao
abstract class carboDao {
  @Query('SELECT * FROM carboEntity')
  Future<List<carboEntity?>> show_data();

  @Query('SELECT * FROM carboEntity WHERE dataString = :dataString')
  Future<carboEntity?> check_carboEntity(String dataString);

  @Query('SELECT * FROM carboEntity WHERE id = :id')
  Future<carboEntity?> check_carboEntity_id(int id);

  @Query(
      'UPDATE carboEntity SET fitbitSteps = :fitbitSteps WHERE dataString = :dataString')
  Future<void> update_fitbitSteps(double fitbitSteps, String dataString);

  @Query(
      'UPDATE carboEntity SET fitbitCals = :fitbitCals WHERE dataString = :dataString')
  Future<void> update_fitbitCals(double fitbitCals, String dataString);

  @Query('UPDATE carboEntity SET value = :value WHERE id = :id')
  Future<void> update_value(double value, int id);

  @Query(
      'UPDATE carboEntity SET carbBurned = :carbBurned WHERE dataString = :dataString')
  Future<void> update_carbBurned(double carbBurned, String dataString);

  @Query(
      'UPDATE carboEntity SET lastTimeRefreshed = :lastTimeRefreshed WHERE dataString = :dataString')
  Future<void> update_lastTimeRefreshed(
      int lastTimeRefreshed, String dataString);

  @Query(
      'UPDATE carboEntity SET lastLimitRefresher = :lastLimitRefresher WHERE dataString = :dataString')
  Future<void> update_lastLimitRefresher(
      int lastLimitRefresher, String dataString);

  @Query('DELETE FROM carboEntity')
  Future<void> delete_all();

  @insert
  Future<void> insert_carboEntity(carboEntity carboentity);
}
