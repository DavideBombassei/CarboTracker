import 'package:floor/floor.dart';

@entity
class carboEntity {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;
  
  final String dataString;
  final double? fitbitSteps;
  final double? fitbitCals;
  final double? value;
  final double? carbBurned;
  final int? lastTimeRefreshed;
  final int? lastLimitRefresher;

  carboEntity(this.id, this.dataString, this.fitbitSteps, this.fitbitCals, this.value, this.carbBurned, this.lastTimeRefreshed, this.lastLimitRefresher);

  @override
  String toString() {
    return '| ${this.id} | ${this.dataString} | ${this.fitbitSteps} | ${this.fitbitCals} | ${this.value} | ${this.carbBurned} | ${this.lastTimeRefreshed} | ${this.lastLimitRefresher} |';
  }
}