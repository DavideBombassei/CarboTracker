import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

int carb = 0; //da sistemare
double carbgrams = 0; //grammi carbo che vado ad aggiungere all'indicatore carbocounter
double buttondim = 60; //dimensione bottoni +-10 +-1
int lim = 500; //limite giornaliero carboidrati per normalizzare entro [0,1] perchè richiesto dall'indicatore

class CarboList extends StatefulWidget {
  @override
  State<CarboList> createState() => _CarboListState();
}

class _CarboListState extends State<CarboList> {
  void _addCarbo10() { //funzione per aggiungere 10g
    setState(() {
      carb += 10;
      print(carb);
    });
  }

  void _addCarbo1() { //funzione per aggiungere 1g
    setState(() {
      carb += 1;
      print(carb);
    });
  }

  void _removeCarbo10() { //funzione per togliere 10g
    setState(() {
      carb -= 10;
      print(carb);
    });
  }

  void _removeCarbo1() { //funzione per togliere 1g
    setState(() {
      carb -= 1;
      print(carb);
    });
  }

  @override
  Widget build(BuildContext context) { 
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Carbo-List'),
      ),
      body: ListView(
        //tiles dei cibi
        children: [ 
          _carboListTile('Bread'),
          _carboListTile('Candies'),
          _carboListTile('Chocolate'),
          _carboListTile('Corn'),
          _carboListTile('Corn-Flakes'),
          _carboListTile('Croissant'),
          _carboListTile('French Fries'),
          _carboListTile('Fruit (Fresh)'),
          _carboListTile('Fruit (Dried)'),
          _carboListTile('Frit Juice'),
          _carboListTile('Honey'),
          _carboListTile('Ice Cream'),
          _carboListTile('Jam'),
          _carboListTile('Legumes'),
          _carboListTile('Milk'),
          _carboListTile('Nutella'),
          _carboListTile('Pasta'),
          _carboListTile('Pizza'),
          _carboListTile('Rice'),
          _carboListTile('Sugar'),
          _carboListTile('Vegetables'),
        ],
      ),
    ));
  }

  //classe per definire i singoli tile
  Widget _carboListTile(String _title) {
    return ExpansionTile(
      title: Text(
        _title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: buttondim,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _removeCarbo1();
                    });
                  },
                  style: TextButton.styleFrom(primary: Colors.red),
                  child: Text('1'),
                ),
              ),
              SizedBox(
                width: buttondim,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _removeCarbo10();
                    });
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text('10'),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  '${carb}g',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: buttondim,
                child: TextButton(
                      onPressed: () {
                        setState(() {
                          _addCarbo10();
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: Text('10'),
                    )
                ),
              SizedBox(
                width: buttondim,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _addCarbo1();
                    });
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text('1'),
                ),
              ),
              SizedBox(
                height: 40,
                width: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      carbgrams = carbgrams + (carb/lim);
                      carb = 0;
                    });
                  },
                  child: Icon(Icons.add),
                  elevation: 0,
                  ),
              ),
            ],
          ),
        ],
      );
  }
}
