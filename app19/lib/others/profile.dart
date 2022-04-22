import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

Profile profile = Profile(name: 'Anna Arnaudo', email: 'anna@gmail,com');

class Profile extends ChangeNotifier {
  String? name;
  String? email;
  double? weight;
  double? height;
  DateTime? dateTime;
  String? birthday;

  //Constructor
  Profile(
      {this.name,
      this.email,
      this.dateTime,
      this.weight,
      this.height,
      this.birthday});
  void editProfile(Profile editProfile) {
    profile = editProfile;
    notifyListeners();
  }
}
