import 'package:flutter/cupertino.dart';

Profile profile = Profile(
    name: 'Anna Arnaudo',
    email: 'anna.arnaudo@gmail.com',
    dateTime: DateTime(2000, 1, 1),
    weight: 62,
    height: 1.62);

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
