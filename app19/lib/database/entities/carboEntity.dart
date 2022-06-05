import 'package:floor/floor.dart';

@entity
class carboEntity {

  @PrimaryKey(autoGenerate: true)
  final int? id;
  
  final String dataString;
  final double? fitbitSteps;
  final double? fitbitCals;
  final double? value;
  final double? carbBurned;

  carboEntity(this.id, this.dataString, this.fitbitSteps, this.fitbitCals, this.value, this.carbBurned);

  @override
  String toString() {
    return '| ${this.id} | ${this.dataString} | ${this.fitbitSteps} | ${this.fitbitCals} | ${this.value} | ${this.carbBurned} |';
  }
}