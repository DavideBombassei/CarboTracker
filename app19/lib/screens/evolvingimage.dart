import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_downloader/image_downloader.dart';

class EvolvingImage extends StatefulWidget {
  @override
  State<EvolvingImage> createState() => _EvolvingImageState();
}

var _pezzo = 1; //queste due variabili sono da salvare altrimenti
var numpuzzle = 1; //chiudendo forzatamente l'app vengono reinizzializate
DateTime _controllDate = DateTime.now();
// TO FIX : https://docs.flutter.dev/cookbook/persistence/key-value

class _EvolvingImageState extends State<EvolvingImage> {
  final val = 13;
  //final numpuzzle = 1;
  String pez = 'pezzo';
  String puz = 'puzzle';
  bool? _checkstatus;

  @override
  void initState() {
    _checkstatus = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controllDate =
        DateTime(_controllDate.year, _controllDate.month, _controllDate.day);
    return Container(
        margin: new EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              'Puzzle',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 50),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              clipBehavior: Clip.antiAlias,
              child: Image.asset('assets/images/$numpuzzle$puz$_pezzo.png',
                  width: 320, height: 320),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              child: Text('Check carbo status'),
              onPressed: () {
                DateTime currentDate = DateTime.now();
                currentDate = DateTime(
                    currentDate.year, currentDate.month, currentDate.day);
                if (currentDate == _controllDate) {
                  _checkstatus = false;
                } else {
                  _checkstatus = true;
                }
                if (val > 10 && val < 20 && _checkstatus == false) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            insetPadding: EdgeInsets.symmetric(horizontal: 40),
                            backgroundColor: Colors.transparent,
                            //insetPadding: EdgeInsets.all(30),
                            content: Stack(
                              overflow: Overflow.visible,
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                    //width: double.infinity,
                                    height: 170,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    padding:
                                        EdgeInsets.fromLTRB(20, 50, 20, 20),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 30),
                                        Text(
                                            "Good job, you have earned a new piece of puzzle",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                            textAlign: TextAlign.center),
                                      ],
                                    )),
                                Positioned(
                                    top: -65,
                                    child: Image.asset(
                                        'assets/images/$numpuzzle$pez${_pezzo + 1}.png',
                                        width: 150,
                                        height: 150))
                              ],
                            ),
                            actions: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: ElevatedButton(
                                        onPressed: _changeImage,
                                        child: Text('Add new piece')),
                                  )
                                ],
                              ),
                            ],
                          ));
                } else {
                  if (val < 10 || val > 20) {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                                content: Text(
                              'Ops! New pieces unavailable',
                              textAlign: TextAlign.center,
                            )));
                  } else {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                                content: Text(
                              'Be patient! You have already unlocked a new piece today',
                              textAlign: TextAlign.center,
                            )));
                  }
                }
              },
            ),
          ],
        ));
  }

  void _changeImage() {
    setState(() {
      if (_pezzo == 9) {
        if (numpuzzle == 4) {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                  content: Text('!!', textAlign: TextAlign.center)));
        } else {}
      } else {
        _pezzo = _pezzo + 4;
      }
      _controllDate = _controllDate.add(const Duration(days: 1));
      Navigator.pop(context);
      if (_pezzo == 9) {
        numpuzzle = numpuzzle + 1;
        _pezzo = 1;
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 40),
                //backgroundColor: Colors.transparent,
                content: Container(
                    width: 170,
                    child: Column(children: [
                      Text('GOOD JOB!, you have completed the puzzle',
                          textAlign: TextAlign.center),
                      Image.asset('assets/images/${numpuzzle - 1}puzzle9.png',
                          width: 150, height: 150),
                      FloatingActionButton(
                        onPressed: _saveImage,
                        child: Icon(Icons.save),
                      )
                    ]))));
      }
    });
  }

  void _saveImage() {
    try {
      // Saved with this method.
      var imageId = ImageDownloader.downloadImage(
        'assets/images/',
      );
      if (imageId == null) {
        return;
      }
    } catch (error) {
      print(error);
    }
  }
}
