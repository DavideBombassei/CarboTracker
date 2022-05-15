import 'package:app19/others/carbohydrates.dart';
import 'package:app19/others/drawerlist.dart';
import 'package:app19/others/numcal.dart';
import 'package:app19/others/numsteps.dart';
import 'package:flutter/material.dart';
import 'package:app19/screens/pageviewdemo.dart';
import 'package:app19/others/profile.dart';
import 'package:provider/provider.dart';

double? num_steps;
double? num_cal;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  Provider.of<numsteps>(context, listen: false)
                      .stepsUpdate(num_steps);
                  print(steps_update);
                  Provider.of<numcal>(context, listen: false).CalUpdate();
                  print(cal_update);
                  Provider.of<carbohydrates>(context, listen: false)
                      .CarboRefresh();
                  print(cal_update);
                });

                /*async {
                  double? steps = await getSteps();
                  num_steps = steps;
                  print(steps);
                });*/
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                Navigator.pop(context, 'login');
              },
              icon: Icon(Icons.logout)),
        ],
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
              backgroundColor: Theme.of(context).colorScheme.background,
              child: Image.asset('assets/images/profile5.png',
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
            SizedBox(
              height: 12,
            ),
            Consumer<Profile>(builder: (context, Profile, child) {
              return (profile.height == null || profile.weight == null)
                  ? Text('')
                  : Text(
                      'BMI: ${((profile.weight!) / ((profile.height!) * (profile.height!))).toStringAsFixed(2)}',
                      //style: TextStyle(color: Color.fromARGB(255, 61, 61, 61))
                    );
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
