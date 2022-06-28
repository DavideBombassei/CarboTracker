import 'package:app19/screens/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

Profile profile = Profile(
    name: profileName,
    dateTime: profileBirthday,
    weight: profileWeight,
    height: profileHeight);

class Profile extends ChangeNotifier {
  String? name;
  double? weight;
  double? height;
  DateTime? dateTime;

  //Constructor
  Profile({
    this.name,
    this.dateTime,
    this.weight,
    this.height,
  });
  void editProfile(Profile editProfile) {
    profile = editProfile;
    notifyListeners();
  }
}
