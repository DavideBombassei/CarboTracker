import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EvolvingImage extends StatefulWidget {
  @override
  State<EvolvingImage> createState() => _EvolvingImageState();
}

class _EvolvingImageState extends State<EvolvingImage> {
  final val = 13;
  String namepezzo = '1pezzo';
  String namepuzzle = '1puzzle';
  var _pezzo = 0;
  var _agg;
  bool? _checkstatus;
  DateTime now = new DateTime.now();
  DateTime _controllDate = new DateTime.now();

  @override
  void initState() {
    _agg = 0;
    _checkstatus = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controllDate = new DateTime(now.year, now.month, now.day);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/$namepuzzle$_pezzo.png'),
        ElevatedButton(
          child: Text('Check carbo status $_controllDate'),
          onPressed: () {
            _pezzo = _pezzo + 1;
            DateTime now2 = new DateTime.now();
            DateTime currentDate =
                new DateTime(now2.year, now2.month, now2.day);
            if (currentDate.compareTo(_controllDate) == 0) {
              _checkstatus = false;
              _controllDate = _controllDate.add(Duration(days: 1));
            } else {
              _checkstatus = true;
            }
            if (val > 10 && val < 20 && _checkstatus == false) {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.all(10),
                        content: Stack(
                          overflow: Overflow.visible,
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                              child: Text(
                                  "                                                                                                                   Bravo, hai guadagnato un nuovo pezzo del puzzle",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color.fromARGB(255, 82, 12, 7)),
                                  textAlign: TextAlign.center),
                            ),
                            Positioned(
                                top: -50,
                                child: Image.asset(
                                    'assets/images/$namepezzo$_pezzo.png',
                                    width: 100,
                                    height: 100))
                          ],
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                              onPressed: _changeImage,
                              child: Text('Add new piece')),
                        ],
                      ));
            } else {
              if (val < 10 || val > 20) {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                        content:
                            Text('Peccato, non ci sono nuovi pezzi per te')));
              } else {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                        content:
                            Text('Hai già ricevuto un nuovo pezzo per oggi')));
              }
            }
          },
        ),
      ],
    );
  }

  void _changeImage() {
    setState(() {
      _agg = _agg + 1;
      _controllDate = _controllDate.add(Duration(days: 1));
      //_checkstatus = true;
      Navigator.pop(context);
    });
  }
}
