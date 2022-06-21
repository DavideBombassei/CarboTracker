import 'package:app19/screens/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

Profile profile = Profile(
    name: profileName,
    email: profileEmail,
    dateTime: profileBirthday,
    weight: profileWeight,
    height: profileHeight);

class Profile extends ChangeNotifier {
  String? name;
  String? email;
  double? weight;
  double? height;
  DateTime? dateTime;

  //Constructor
  Profile({
    this.name,
    this.email,
    this.dateTime,
    this.weight,
    this.height,
  });
  void editProfile(Profile editProfile) {
    profile = editProfile;
    notifyListeners();
  }
}
