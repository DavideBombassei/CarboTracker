import 'package:flutter/material.dart';

class CarboList extends StatefulWidget {
  const CarboList({Key? key}) : super(key: key);

  @override
  State<CarboList> createState() => _CarboListState();
}

class _CarboListState extends State<CarboList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Carbo-List'),
      ),
      body: ListView(
        children: [
          TileGenerator('Banana'),
          TileGenerator('Chocolate'),
          TileGenerator('Others')
        ],
      ),
    ));
  }
}

//Ad Hoc Widget written to semplify the generation of tiles in the carbolist.
//In future could be also used by users to add unlisted food
Widget TileGenerator(String Title) {
  int carb = 0;

  return ExpansionTile(
    title: Text(
      Title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    children: [
      Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
                color: Colors.green,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.remove),
                color: Colors.red,
              ),
            ],
          ),
          Row(
            children: [Text('       $carb       ')],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
                color: Colors.green,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.remove),
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
