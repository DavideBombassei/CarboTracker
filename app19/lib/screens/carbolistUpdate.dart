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

  Item({
    //required this.expandedValue,
    required this.header,
    this.body,
    this.isExpanded = false,
    required this.carbperc,
  });
}

class _CarboListUpdateState extends State<CarboListUpdate> {
  List<Item> items = <Item>[
    Item(header: 'Bread', carbperc: 0.6),
    Item(header: 'Candies', carbperc: 0.9),
    Item(header: 'Chocolate', carbperc: 0.5),
    Item(header: 'Corn', carbperc: 0.75),
    Item(header: 'Corn-Flakes', carbperc: 0.9),
    Item(header: 'Croissant', carbperc: 0.55),
    Item(header: 'Dried Fruit', carbperc: 0.7),
    Item(header: 'French Fries', carbperc: 0.4),
    Item(header: 'Fresh Fruit', carbperc: 0.1),
    Item(header: 'Fruit Juice', carbperc: 0.15),
    Item(header: 'Honey', carbperc: 0.8),
    Item(header: 'Ice Cream', carbperc: 0.25),
    Item(header: 'Jam', carbperc: 0.6),
    Item(header: 'Legumes', carbperc: 0.5),
    Item(header: 'Milk', carbperc: 0.05),
    Item(header: 'Nutella', carbperc: 0.6),
    Item(header: 'Pasta', carbperc: 0.7),
    Item(header: 'Pizza', carbperc: 0.6),
    Item(header: 'Rice', carbperc: 0.8),
    Item(header: 'Sugar', carbperc: 1),
    Item(header: 'Vegetables', carbperc: 0.07),
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
        /*actions: [
      IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: MySearchDelegate(),
            );
          }),
    ],*/
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
                  body: _CarbCalculator(item.carbperc)))
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

  // ignore: non_constant_identifier_names
  Widget _CarbCalculator(carbperc) {
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

/*class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    'Bread',
    'Candies',
    'Chocolate',
    'Corn',
    'Corn-Flakes',
    'Croissant',
    'French Fries',
    'Fruit (Fresh)',
    'Fruit (Dried)',
    'Fruit Juice',
    'Honey',
    'Ice Cream',
    'Jam',
    'Legumes',
    'Milk',
    'Nutella',
    'Pasta',
    'Pizza',
    'Rice',
    'Sugar',
    'Vegetables'
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          return close(context, null);
        },
        icon: Icon(Icons.arrow_back),
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
    );
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              showResults(context);
            },
          );
        });
  }
}*/