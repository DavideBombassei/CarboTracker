import 'package:app19/others/carbohydrates.dart';
import 'package:flutter/material.dart';
import 'package:app19/screens/carbolist.dart';
import 'package:provider/provider.dart';

class CarboCounter extends StatefulWidget {

  @override
  State<CarboCounter> createState() => _CarboCounterState();
}

class _CarboCounterState extends State<CarboCounter> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100.0),
      child: Column(
        children: [
          Text('CarboCounter'),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            child: Consumer<carbohydrates>(
              builder: (context, carbohydrates, child){
                return CircularProgressIndicator(
                  value: carbgrams,
                  backgroundColor: Colors.grey,
                  color: Colors.blue,
                  strokeWidth: 30,
                );
              }
            ),
            height: 200,
            width: 200,
          ),
        ],
      ),
    );
  }
}