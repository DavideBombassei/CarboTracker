import 'package:app19/others/carbohydrates.dart';
import 'package:flutter/material.dart';
import 'package:app19/screens/carbolist.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CarboCounter extends StatefulWidget {
  @override
  State<CarboCounter> createState() => _CarboCounterState();
}

class _CarboCounterState extends State<CarboCounter> {
  List<String> phrases = [
    'Qui pensavo di mettere storie, frasi motivazionali, curiosità, o info varie che cambiano ogni 30 secondi'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Column(children: [
        Text(
          'CarboCounter',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 80,
        ),
        SizedBox(
          child:
              Consumer<carbohydrates>(builder: (context, carbohydrates, child) {
            return CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              value: carbgrams,
              strokeWidth: 30,
            );
          }),
          height: 200,
          width: 200,
        ),
        Container(
          padding: EdgeInsets.all(60),
          child: AnimatedTextKit(animatedTexts: [
            TypewriterAnimatedText(
              phrases.first,
              textAlign: TextAlign.center,
              textStyle: TextStyle(fontSize: 16),
              speed: Duration(milliseconds: 100),
            ),
          ]),
        )
      ]),
    );
  }
}
