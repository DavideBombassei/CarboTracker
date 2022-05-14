import 'package:flutter/material.dart';

import '../screens/carbocounter.dart';

double? cal_update = 0.0;

class numcal extends ChangeNotifier {
  void CalUpdate(double? num_cal) async {
    double? cal = await getCal();
    cal_update = cal;

    notifyListeners();
    if (cal_update! < 10) {
      adjuster_x = 15;
    } else {
      if (cal_update! < 100.0) {
        adjuster_x = 8;
      } else {
        if (cal_update! < 1000.0) {
          adjuster_x = 5;
        } else {
          if (cal_update! < 10000.0) {
            adjuster_x = 1;
          } else {
            if (cal_update! < 100000.0) {
              adjuster_x = -4;
            }
          }
        }
      }
    }
  }
}
