import 'dart:math';

import 'package:app19/others/carbohydrates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CarboCounter extends StatefulWidget {
  @override
  State<CarboCounter> createState() => _CarboCounterState();
}

class _CarboCounterState extends State<CarboCounter> {
  List<String> phrases = [
    'Solo chi rischia di andare troppo lontano avrà la possibilità di scoprire quanto lontano si può andare',
    'Se non credi in te stesso, nessuno lo farà per te',
    'Quando ti dicono che non puoi farcela, ti stanno mostrando i loro limiti, non i tuoi',
    'Senza ambizione non si inizia nulla. Senza lavoro non si finisce nulla. Il successo non ti verrà regalato. Devi conquistarlo',
    'La vita è per il 10% cosa ti accade e per il 90% come reagisci'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Column(children: [
        Text(
          'CarboCounter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 80,
        ),
        SizedBox(
          child:
              Consumer<carbohydrates>(builder: (context, carbohydrates, child) {
            return CircularProgressIndicator(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              value: carbgrams,
              strokeWidth: 30,
            );
          }),
          height: 200,
          width: 200,
        ),
        Container(
          color: Colors.amber,
        ),
        /*Container(
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                left: -96,
                top: 96,
                child: Container(
                  child: Container(
                    child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                      TyperAnimatedText(
                        phrases[Random().nextInt(phrases.length)],
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'Comic Sans',
                          fontStyle: FontStyle.italic,
                        ),
                        speed: const Duration(milliseconds: 100),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 220,
                  height: 140,
                ),
              ),
              Positioned(
                left: 60,
                top: 200,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 120,
                  height: 80,
                ),
              ),
              Positioned(
                child: Container(
                  width: 80,
                  height: 80,
                ),
              )
            ],
          ),
        )*/
        Container(
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 40),
          child: DefaultTextStyle(
            style: GoogleFonts.reenieBeanie(
                fontSize: 28.0, color: Theme.of(context).unselectedWidgetColor),
            //style: GoogleFonts.tangerine(
            //    fontSize: 28.0, color: Theme.of(context).unselectedWidgetColor),
            //style: GoogleFonts.oleoScriptSwashCaps(
            //    fontSize: 18.0, color: Theme.of(context).unselectedWidgetColor),
            //style: GoogleFonts.pressStart2p(
            //    height: 1.5,
            //    fontSize: 10.0,
            //    color: Theme.of(context).unselectedWidgetColor),
            //style: GoogleFonts.pacifico(
            //    fontSize: 18.0, color: Theme.of(context).unselectedWidgetColor),
            //style: GoogleFonts.lobster(
            //    fontSize: 18.0, color: Theme.of(context).unselectedWidgetColor),
            child: AnimatedTextKit(repeatForever: true, animatedTexts: [
              TyperAnimatedText(
                phrases[Random().nextInt(phrases.length)],
                speed: const Duration(milliseconds: 100),
                textAlign: TextAlign.center,
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
