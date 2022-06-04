import 'package:flutter/material.dart';
import '../screens/carbocounter.dart';

double? steps_update = 0.0;

class numsteps extends ChangeNotifier {
  Future stepsUpdate() async {
    double? steps = await getSteps();
    steps_update = steps;

    notifyListeners();
    if (steps_update! < 10) {
      adjuster_x = 15;
    } else {
      if (steps_update! < 100.0) {
        adjuster_x = 8;
      } else {
        if (steps_update! < 1000.0) {
          adjuster_x = 5;
        } else {
          if (steps_update! < 10000.0) {
            adjuster_x = 1;
          } else {
            if (steps_update! < 100000.0) {
              adjuster_x = -4;
            }
          }
        }
      }
    }
  }
}
