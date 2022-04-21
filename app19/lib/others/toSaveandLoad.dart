import 'package:shared_preferences/shared_preferences.dart';

addIntToSP(String VarName, int VarValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(VarName, VarValue);
}

getIntFromSP(String VarName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int? intValue = prefs.getInt(VarName);
  return intValue;
}

checkValue(String VarName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool checkexistence = prefs.containsKey(VarName);
  return checkexistence;
}