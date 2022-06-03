import 'package:app19/database/entities/carboEntity.dart';
import 'package:floor/floor.dart';

@dao
abstract class carboDao {

  @Query('SELECT * FROM carboEntity WHERE dataString = :dataString')
  Future<carboEntity?> check_carboEntity(dataString);

  @insert
  Future<void> insert_carboEntity(carboEntity carboentity);

}