import 'package:flutter/material.dart';
import 'package:app19/others/carbohydrates.dart';
import 'package:provider/provider.dart';

int carb = 0; //da sistemare
double buttondim = 60; //dimensione bottoni +-10 +-1
int lim =
    500; //limite giornaliero carboidrati per normalizzare entro [0,1] perchè richiesto dall'indicatore

class CarboListUpdate extends StatefulWidget {
  @override
  State<CarboListUpdate> createState() => _CarboListUpdateState();
}

class Item {
//String expandedValue;
  final String header;
  final Widget? body;
  bool isExpanded;
  double carbperc;
  int index;

  Item({
    //required this.expandedValue,
    required this.header,
    this.body,
    this.isExpanded = false,
    required this.carbperc,
    required this.index,
  });
}

class _CarboListUpdateState extends State<CarboListUpdate> {
  List<Item> items = <Item>[
    Item(header: 'Bread', carbperc: 0.6, index: 1),
    Item(header: 'Candies', carbperc: 0.9, index: 2),
    Item(header: 'Chocolate', carbperc: 0.5, index: 3),
    Item(header: 'Corn', carbperc: 0.75, index: 4),
    Item(header: 'Corn-Flakes', carbperc: 0.9, index: 5),
    Item(header: 'Croissant', carbperc: 0.55, index: 6),
    Item(header: 'Dried Fruit', carbperc: 0.7, index: 7),
    Item(header: 'French Fries', carbperc: 0.4, index: 8),
    Item(header: 'Fresh Fruit', carbperc: 0.1, index: 9),
    Item(header: 'Fruit Juice', carbperc: 0.15, index: 10),
    Item(header: 'Honey', carbperc: 0.8, index: 11),
    Item(header: 'Ice Cream', carbperc: 0.25, index: 12),
    Item(header: 'Jam', carbperc: 0.6, index: 13),
    Item(header: 'Legumes', carbperc: 0.5, index: 14),
    Item(header: 'Milk', carbperc: 0.05, index: 15),
    Item(header: 'Nutella', carbperc: 0.6, index: 16),
    Item(header: 'Pasta', carbperc: 0.7, index: 17),
    Item(header: 'Pizza', carbperc: 0.6, index: 18),
    Item(header: 'Rice', carbperc: 0.8, index: 19),
    Item(header: 'Sugar', carbperc: 1, index: 20),
    Item(header: 'Vegetables', carbperc: 0.07, index: 21),
  ];

  void _addCarbo10() {
    //funzione per aggiungere 10g
    setState(() {
      carb += 10;
    });
  }

  void _addCarbo1() {
    //funzione per aggiungere 1g
    setState(() {
      carb += 1;
    });
  }

  void _removeCarbo10() {
    //funzione per togliere 10g
    setState(() {
      carb -= 10;
    });
  }

  void _removeCarbo1() {
    //funzione per togliere 1g
    setState(() {
      carb -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carbo-List'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: items
              .map((item) => ExpansionPanelRadio(
                  canTapOnHeader: true,
                  value: item.header,
                  headerBuilder: (context, isExpanded) => ListTile(
                        title: Text(
                          item.header,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                  body: _CarbCalculator(item.carbperc, item.index)))
              .toList(),
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              carb = 0;
            });
          },
        ),
      ),
    );
  }

  Widget _CarbCalculator(carbperc, i) {
    return Column(
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
                )),
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
                heroTag: "btn$i",
                onPressed: () {
                  setState(() {
                    Provider.of<carbohydrates>(context, listen: false)
                        .addcarbo(carb, lim, carbperc);
                    carb = 0;
                    print(carbgrams);
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
