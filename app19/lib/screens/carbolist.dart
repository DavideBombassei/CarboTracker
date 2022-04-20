import 'package:flutter/material.dart';
import 'package:app19/others/carbohydrates.dart';
import 'package:provider/provider.dart';

int carb = 0; //da sistemare
double buttondim = 60; //dimensione bottoni +-10 +-1
int lim =
    500; //limite giornaliero carboidrati per normalizzare entro [0,1] perchè richiesto dall'indicatore

class CarboList extends StatefulWidget {
  @override
  State<CarboList> createState() => _CarboListState();
}

class _CarboListState extends State<CarboList> {
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
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Carbo-List'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              }),
        ],
      ),
      body: ListView(
        //tiles dei cibi
        children: [
          _carboListTile('Bread', 0.6),
          _carboListTile('Candies', 0.9),
          _carboListTile('Chocolate', 0.5),
          _carboListTile('Corn', 0.75),
          _carboListTile('Corn-Flakes', 0.9),
          _carboListTile('Croissant', 0.55),
          _carboListTile('French Fries', 0.4),
          _carboListTile('Fruit (Fresh)', 0.1),
          _carboListTile('Fruit (Dried)', 0.7),
          _carboListTile('Frit Juice', 0.15),
          _carboListTile('Honey', 0.8),
          _carboListTile('Ice Cream', 0.25),
          _carboListTile('Jam', 0.6),
          _carboListTile('Legumes', 0.5),
          _carboListTile('Milk', 0.05),
          _carboListTile('Nutella', 0.6),
          _carboListTile('Pasta', 0.7),
          _carboListTile('Pizza', 0.6),
          _carboListTile('Rice', 0.8),
          _carboListTile('Sugar', 1),
          _carboListTile('Vegetables', 0.07),
        ],
      ),
    ));
  }

  //classe per definire i singoli tile
  // carbperc prende la percentale di carbo in ogni cibo
  Widget _carboListTile(String _title, double carbperc) {
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

class MySearchDelegate extends SearchDelegate {
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
    'ecc...'
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
}
