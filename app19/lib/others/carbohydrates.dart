import 'package:flutter/material.dart';

double carbgrams = 0;

class carbohydrates extends ChangeNotifier {
  void addcarbo(int carb, int lim, double carbperc) {
    carbgrams = carbgrams + ((carb * carbperc) / lim);
    notifyListeners();
  }

  Future CarboRefresh() async{
    carbgrams = carbgrams;
    notifyListeners();
  }
}

