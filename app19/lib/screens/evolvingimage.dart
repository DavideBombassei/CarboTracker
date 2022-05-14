import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EvolvingImage extends StatefulWidget {
  @override
  State<EvolvingImage> createState() => _EvolvingImageState();
}

int _pezzo = 1; //queste due variabili sono da salvare altrimenti
int numpuzzle = 1; //chiudendo forzatamente l'app vengono reinizzializate
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
    populatefields();
  }

  void populatefields() async {
    final valuepezzo = await getpezzo();
    final valuepuzzle = await getpuzzle();
    setState(() {
      _pezzo = valuepezzo;
      numpuzzle = valuepuzzle;
    });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                                insetPadding:
                                    EdgeInsets.symmetric(horizontal: 40),
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear();
                  },
                  child: Text('delete saved data'),
                ),
              ],
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
        savepezzo();
      }
      _controllDate = _controllDate.add(const Duration(days: 1));
      Navigator.pop(context);
      if (_pezzo == 9) {
        numpuzzle = numpuzzle + 1;
        _pezzo = 1;
        savepezzo();
        savepuzzle();
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

Future<int> getpezzo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final _pezzo = prefs.getInt('_pezzo') ?? 1;
  return _pezzo;
}

Future savepezzo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('_pezzo', _pezzo);
}

Future<int> getpuzzle() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final numpuzzle = prefs.getInt('numpuzzle') ?? 1;
  return numpuzzle;
}

Future savepuzzle() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('numpuzzle', numpuzzle);
}
