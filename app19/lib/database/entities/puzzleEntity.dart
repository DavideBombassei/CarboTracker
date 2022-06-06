import 'package:app19/database/entities/carboEntity.dart';
import 'package:floor/floor.dart';

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['id'],
      parentColumns: ['id'],
      entity: carboEntity
      )
    ]
  )
  
class puzzleEntity {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;
  
  final String dataString;
  final int? numPuzzle;
  final int? numPezzo;
  final bool? alreadyClicked;

  puzzleEntity(this.id, this.dataString, this.numPuzzle, this.numPezzo, this.alreadyClicked);

  @override
  String toString() {
    return '| ${this.id} | ${this.dataString} | ${this.numPuzzle} | ${this.numPezzo} | ${this.alreadyClicked} |';
  }
}