import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22),
      child: Wrap(
        runSpacing: 4,
        children: [
          ListTile(
            leading: const Icon(Icons.addchart_rounded),
            title: const Text(
              'Carbo-List',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'carbolistUpdate');
            },
            trailing: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'carbolistUpdate');
                },
                icon: Icon(Icons.arrow_right)),
          ),
          ListTile(
            leading: const Icon(Icons.portrait_outlined),
            title: const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'settings');
            },
            trailing: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'settings');
                },
                icon: Icon(Icons.arrow_right)),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text(
              'Info',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'info');
            },
            trailing: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'info');
                },
                icon: Icon(Icons.arrow_right)),
          ),
        ],
      ),
    );
  }
}
