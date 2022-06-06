import 'package:app19/repository/databaseRepository.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';

class EvolvingImage extends StatefulWidget {
  @override
  State<EvolvingImage> createState() => _EvolvingImageState();
}

int _pezzo = 1; //queste due variabili sono da salvare altrimenti
int numpuzzle = 1; //chiudendo forzatamente l'app vengono reinizzializate
// TO FIX : https://docs.flutter.dev/cookbook/persistence/key-value

class _EvolvingImageState extends State<EvolvingImage> {
  double val = 0;
  //final numpuzzle = 1;
  String pez = 'pezzo';
  String puz = 'puzzle';

  @override
  void initState() {
    super.initState();
    populatefields();
  }

  void populatefields() async {
    DateTime temp = DateTime.now();
    String dataString = temp.year.toString() +
        temp.month.toString() +
        temp.day.toString();
    int? ID = await Provider.of<DatabaseRepository>(context, listen: false).get_id(dataString) ?? 0;
    bool? whichPiece = await Provider.of<DatabaseRepository>(context, listen: false).get_alreadyClicked(dataString);
    bool? whichPuzzle = await Provider.of<DatabaseRepository>(context, listen: false).get_alreadyClicked(dataString);
    if (whichPiece == false) {
      final valuepezzo = await Provider.of<DatabaseRepository>(context,listen: false).get_numPezzo(ID);
      _pezzo = valuepezzo ?? 1;
    }
    else {
      final valuepezzo = await Provider.of<DatabaseRepository>(context,listen: false).get_numPezzo(ID+1);
      _pezzo = valuepezzo ?? 1;
    }
    if (whichPuzzle == false) {
      final valuepuzzle = await Provider.of<DatabaseRepository>(context,listen: false).get_numPuzzle(ID);
      numpuzzle = valuepuzzle ?? 1;
    }
    else {
      final valuepuzzle = await Provider.of<DatabaseRepository>(context,listen: false).get_numPuzzle(ID+1);
      numpuzzle = valuepuzzle ?? 1;
    }
    setState(() {
      _pezzo = _pezzo;
      numpuzzle = numpuzzle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: new EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 46),
            /*Text(
              'Puzzle',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),*/
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
              onPressed: () async {
                DateTime temp = DateTime.now();
                String dataString = temp.year.toString() +
                    temp.month.toString() +
                    temp.day.toString();
                bool? alreadyClicked = await Provider.of<DatabaseRepository>(context, listen: false).get_alreadyClicked(dataString);
                int? ID = await Provider.of<DatabaseRepository>(context, listen: false).get_id(dataString) ?? 0;
                val = await Provider.of<DatabaseRepository>(context, listen: false).get_value(ID-1) ?? 0;
                if (val < 1 && alreadyClicked == false) {
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
                  if (val >= 1) {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                                content: Text(
                              'Ops! Yesterday you did not well',
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

  void _changeImage() async {
    DateTime temp = DateTime.now();
    String dataString = temp.year.toString() +
        temp.month.toString() +
        temp.day.toString();
    if (_pezzo == 9) {
      if (numpuzzle == 4) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                content: Text('!!', textAlign: TextAlign.center)));
      } else {}
    } else {
      _pezzo = _pezzo + 1;
      await Provider.of<DatabaseRepository>(context, listen: false).update_numPezzo(_pezzo, dataString);
      await Provider.of<DatabaseRepository>(context, listen: false).update_alreadyClicked(true, dataString);
    }
    Navigator.pop(context);
    if (_pezzo == 9) {
      numpuzzle = numpuzzle + 1;
      _pezzo = 1;
      await Provider.of<DatabaseRepository>(context, listen: false).update_numPezzo(_pezzo, dataString);
      await Provider.of<DatabaseRepository>(context, listen: false).update_numPuzzle(numpuzzle, dataString);
      await Provider.of<DatabaseRepository>(context, listen: false).update_alreadyClicked(true, dataString);
      /*showDialog(
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
                  ]))));*/
    }
    setState(() {});
  }

  /*void _saveImage() {
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
  }*/
}
