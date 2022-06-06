import 'package:app19/database/entities/puzzleEntity.dart';
import 'package:floor/floor.dart';

@dao
abstract class puzzleDao {

  @Query('SELECT * FROM puzzleEntity WHERE dataString = :dataString')
  Future<puzzleEntity?> check_puzzleEntity(String dataString);

  @Query('SELECT * FROM puzzleEntity WHERE id = :id')
  Future<puzzleEntity?> check_puzzleEntity_id(int id);

  @Query('UPDATE puzzleEntity SET numPuzzle = :numPuzzle WHERE dataString = :dataString')
  Future<void> update_numPuzzle(int numPuzzle, String dataString);

  @Query('UPDATE puzzleEntity SET numPezzo = :numPezzo WHERE dataString = :dataString')
  Future<void> update_numPezzo(int numPezzo, String dataString);

  @Query('UPDATE puzzleEntity SET alreadyClicked = :alreadyClicked WHERE dataString = :dataString')
  Future<void> update_alreadyClicked(bool alreadyClicked, String dataString);

  @Query('DELETE FROM puzzleEntity')
  Future<void> delete_all_puzzle();

  @insert
  Future<void> insert_puzzleEntity(puzzleEntity puzzleentity);

}