import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.portrait_outlined),
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'profilepage');
              },
              icon: Icon(Icons.arrow_right)),
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text(
            'Carbo-List',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'carbolist');
              },
              icon: Icon(Icons.arrow_right)),
        ),
        ListTile(
          leading: const Icon(Icons.calendar_month),
          title: const Text(
            'Calendar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'calendar');
              },
              icon: const Icon(Icons.arrow_right)),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'settings');
              },
              icon: Icon(Icons.arrow_right)),
        ),
      ],
    );
  }
}
