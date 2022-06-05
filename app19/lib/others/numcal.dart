import 'package:app19/others/carbohydrates.dart';
import 'package:app19/screens/carbolistUpdate.dart';
import 'package:flutter/material.dart';
import '../screens/carbocounter.dart';

double? cal_update = 0.0;
double? cal_carbocounter = 0.0;
double? cal_carbocounter_static = 0.0;

class numcal extends ChangeNotifier {
  Future CalUpdate() async {
    double? cal = await getCal();
    cal_update = cal;

    cal_carbocounter =
        (((cal_update! * 0.33) / 4) / lim) - cal_carbocounter_static!;
    cal_carbocounter_static = cal_carbocounter_static! + cal_carbocounter!;
    print('Calstatic $cal_carbocounter_static');

    carbgrams = carbgrams - cal_carbocounter!;

    print('Carb bruciati $cal_carbocounter');
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

  Future calsRefresh() async {
    cal_update = cal_update;
    notifyListeners();
  }
}
