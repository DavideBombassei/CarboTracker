import 'package:floor/floor.dart';

@entity
class carboEntity {

  @primaryKey
  final String? dataString;

  final double? fitbitSteps;
  final double? fitbitCals;
  final double? value;

  carboEntity({this.dataString, this.fitbitSteps, this.fitbitCals, this.value});

}