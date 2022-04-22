import 'package:app19/others/drawerlist.dart';
import 'package:app19/screens/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:app19/screens/pageviewdemo.dart';
import 'package:app19/others/profile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
      ),
      body: PageViewDemo(),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ]),
    ));
  }

  buildHeader(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            CircleAvatar(
              child: Image.asset('assets/images/logo.png',
                  width: 250, height: 250),
              radius: 50.0,
            ),
            SizedBox(
              height: 12,
            ),
            Consumer<Profile>(builder: (context, Profile, child) {
              return Text('${profile.name}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
            }),
            Consumer<Profile>(builder: (context, Profile, child) {
              return Text('${profile.email}');
            }),
          ],
        ),
      ),
    );
  }

  buildMenuItems(BuildContext context) {
    return DrawerList();
  }
}
