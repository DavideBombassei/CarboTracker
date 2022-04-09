import 'package:app19/others/drawerlist.dart';
import 'package:flutter/material.dart';
import 'package:app19/screens/pageviewdemo.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Scaffold(
        appBar: AppBar(
          title: const Text('Drawer'),
        ),
        body: DrawerList(),
      )),
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
      ),
      body: PageViewDemo(),
    );
  }
}
