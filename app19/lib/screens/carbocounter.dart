import 'package:flutter/material.dart';
import 'package:app19/screens/carbolist.dart';

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
            child: CircularProgressIndicator(
              value: carbgrams,
              backgroundColor: Colors.grey,
              color: Colors.blue,
              strokeWidth: 30,
            ),
            height: 200,
            width: 200,
          ),
        ],
      ),
    );
  }
}