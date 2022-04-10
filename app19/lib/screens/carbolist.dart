import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

int carb = 0;

class CarboList extends StatefulWidget {
  @override
  State<CarboList> createState() => _CarboListState();
}

class _CarboListState extends State<CarboList> {
  void _addCarbo10() {
    setState(() {
      carb += 10;
      print(carb);
    });
  }

  void _addCarbo1() {
    setState(() {
      carb += 1;
      print(carb);
    });
  }

  void _removeCarbo10() {
    setState(() {
      carb -= 10;
      print(carb);
    });
  }

  void _removeCarbo1() {
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

  Widget _carboListTile(String _title) {
    return ExpansionTile(
      title: Text(
        _title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _removeCarbo1();
                    });
                  },
                  style: TextButton.styleFrom(primary: Colors.red),
                  child: Text('-1'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _removeCarbo10();
                    });
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text('-10'),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '       ${carb}g       ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _addCarbo10();
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: Text('+10'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _addCarbo1();
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: Text('+1'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
