import 'dart:math';
import 'dart:async';
import 'package:app19/others/numcal.dart';
import 'package:app19/others/numsteps.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:app19/others/carbohydrates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app19/repository/databaseRepository.dart';
import 'package:app19/others/carbohydrates.dart';

double adjuster_x = 15;

class CarboCounter extends StatefulWidget {
  @override
  State<CarboCounter> createState() => _CarboCounterState();
}

class _CarboCounterState extends State<CarboCounter> {
  void populatefields_carbo() async {
    DateTime temp = DateTime.now();
    String dataString =
        temp.year.toString() + temp.month.toString() + temp.day.toString();
    int? ID = await Provider.of<DatabaseRepository>(context, listen: false)
            .get_id(dataString) ??
        0;
    carbgrams = await Provider.of<DatabaseRepository>(context, listen: false)
            .get_value(ID) ??
        0;
    print(carbgrams);
    await Provider.of<carbohydrates>(context, listen: false).CarboRefresh();
    steps_update = await Provider.of<DatabaseRepository>(context, listen: false)
            .get_fitbitSteps(dataString) ??
        0.0;
    cal_update = await Provider.of<DatabaseRepository>(context, listen: false)
            .get_fitbitCals(dataString) ??
        0.0;
    await Provider.of<numsteps>(context, listen: false).stepsRefresh();
    await Provider.of<numcal>(context, listen: false).calsRefresh();
  }

  @override
  void initState() {
    super.initState();
    populatefields_carbo();
  }

  List<String> phrases = [
    //'Solo chi rischia di andare troppo lontano avrà la possibilità di scoprire quanto lontano si può andare',
    'Se non credi in te stesso, nessuno lo farà per te',
    'Quando ti dicono che non puoi farcela, ti stanno mostrando i loro limiti, non i tuoi',
    //'Senza ambizione non si inizia nulla. Senza lavoro non si finisce nulla. Il successo non ti verrà regalato. Devi conquistarlo',
    'La vita è per il 10% cosa ti accade e per il 90% come reagisci'
  ];

  @override
  Widget build(BuildContext context) {
    double infoposition_y = 36.0;
    double infoposition_x = 70.0;
    //double? stepsValue = 0;

    //Timer mytimer = Timer.periodic(Duration(minutes:1), (timer) async{
    //double? temp = await getSteps();
    //setState(() {
    //stepsValue = temp;
    //});
    //});

    return Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Column(children: [
        /*Text(
          'CarboCounter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),*/
        SizedBox(
          height: 80,
        ),
        Stack(children: [
          SizedBox(
            child: Consumer<carbohydrates>(
                builder: (context, carbohydrates, child) {
              return CircularProgressIndicator(
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                value: carbgrams,
                strokeWidth: 30,
              );
            }),
            height: 200,
            width: 200,
          ),
          Consumer<numsteps>(
            builder: (context, value, child) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: infoposition_y + 30,
                    horizontal: infoposition_x + adjuster_x),
                child: Text(
                  '$steps_update',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).unselectedWidgetColor),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: infoposition_y, horizontal: infoposition_x + 14),
            child: Icon(
              Icons.run_circle_outlined,
              size: 30,
              color: Theme.of(context).unselectedWidgetColor,
            ),
          ),
          Consumer<numcal>(
            builder: (context, value, child) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: infoposition_y + 100,
                    horizontal: infoposition_x + adjuster_x),
                child: Text(
                  '$cal_update',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).unselectedWidgetColor),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: infoposition_y + 70, horizontal: infoposition_x + 14),
            child: Icon(
              Icons.local_fire_department,
              size: 30,
              color: Theme.of(context).unselectedWidgetColor,
            ),
          ),
        ]),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: DefaultTextStyle(
            style: GoogleFonts.reenieBeanie(
                fontSize: 28.0, color: Theme.of(context).unselectedWidgetColor),
            child: AnimatedTextKit(repeatForever: true, animatedTexts: [
              TyperAnimatedText(
                phrases[Random().nextInt(phrases.length)],
                speed: const Duration(milliseconds: 100),
                textAlign: TextAlign.center,
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

Future<double?> getSteps() async {
  FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager =
      FitbitActivityTimeseriesDataManager(
    clientID: '238CL6',
    clientSecret: '9ba8e03acc6170c27f5654037ee7a13a',
    type: 'steps',
  );
  final stepsData = await fitbitActivityTimeseriesDataManager
      .fetch(FitbitActivityTimeseriesAPIURL.dayWithResource(
    date: DateTime.now().subtract(Duration(days: 0)),
    userID: '7ML2XV',
    resource: fitbitActivityTimeseriesDataManager.type,
  )) as List<FitbitActivityTimeseriesData>;
  print(stepsData);
  return stepsData[0].value;
}

Future<double?> getCal() async {
  FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager =
      FitbitActivityTimeseriesDataManager(
    clientID: '238CL6',
    clientSecret: '9ba8e03acc6170c27f5654037ee7a13a',
    type: 'activityCalories',
  );
  final calData = await fitbitActivityTimeseriesDataManager
      .fetch(FitbitActivityTimeseriesAPIURL.dayWithResource(
    date: DateTime.now().subtract(Duration(days: 0)),
    userID: '7ML2XV',
    resource: fitbitActivityTimeseriesDataManager.type,
  )) as List<FitbitActivityTimeseriesData>;
  print(calData);
  return calData[0].value;
}
