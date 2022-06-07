import 'package:app19/others/carbohydrates.dart';
import 'package:app19/others/drawerlist.dart';
import 'package:app19/others/numcal.dart';
import 'package:app19/others/numsteps.dart';
import 'package:flutter/material.dart';
import 'package:app19/screens/pageviewdemo.dart';
import 'package:app19/others/profile.dart';
import 'package:provider/provider.dart';
import 'package:app19/repository/databaseRepository.dart';
import 'package:fitbitter/fitbitter.dart';

bool oneTimeOnly = true;

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
              onPressed: () async {
                /*bool valid = await FitbitConnector.isTokenValid();
                print(valid);
                if (!valid) {
                  await FitbitConnector.refreshToken(
                    clientID: '238CL6',
                    clientSecret: '9ba8e03acc6170c27f5654037ee7a13a',
                  );
                }*/
                DateTime temp = DateTime.now();
                String dataString = temp.year.toString() +
                    temp.month.toString() +
                    temp.day.toString();
                int okRefreshed = await Provider.of<DatabaseRepository>(context,listen: false).get_lastTimeRefreshed(dataString) ?? 0;
                int limitRefresher = await Provider.of<DatabaseRepository>(context,listen: false).get_lastLimitRefresher(dataString) ?? 0;

                if (okRefreshed >= limitRefresher) {

                  await Provider.of<numsteps>(context, listen: false)
                    .stepsUpdate();
                  print(steps_update);
                  double toaddCarbo = await Provider.of<DatabaseRepository>(context, listen: false).get_carbBurned(dataString) ?? 0;
                  if (oneTimeOnly) {
                    carbgrams = carbgrams + toaddCarbo;
                    oneTimeOnly = false;
                  }
                  await Provider.of<numcal>(context, listen: false).CalUpdate();
                  print(cal_update);
                  await Provider.of<carbohydrates>(context, listen: false)
                      .CarboRefresh();
                  print(cal_update);
                  await Provider.of<DatabaseRepository>(context, listen: false)
                      .update_fitbitSteps(steps_update ?? 0, dataString);
                  await Provider.of<DatabaseRepository>(context, listen: false)
                      .update_fitbitCals(cal_update ?? 0, dataString);
                  int? ID = await Provider.of<DatabaseRepository>(context, listen: false).get_id(dataString) ?? 0;
                  await Provider.of<DatabaseRepository>(context, listen: false).update_value(carbgrams, ID);
                  await Provider.of<DatabaseRepository>(context, listen: false).update_carbBurned(cal_carbocounter_static ?? 0, dataString);

                  limitRefresher = okRefreshed + 1;
                  if (limitRefresher >= 24) {
                    limitRefresher = 0;
                  }

                  await Provider.of<DatabaseRepository>(context, listen: false).update_lastLimitRefresher(limitRefresher, dataString);

                }

                else {
                  print('can not update, must wait till $limitRefresher');
                }

                setState(() {});
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () async {
                /*bool valid = await FitbitConnector.isTokenValid();
                print(valid);
                if (valid) {
                  await FitbitConnector.unauthorize(
                    clientID: '238CL6',
                    clientSecret: '9ba8e03acc6170c27f5654037ee7a13a',
                  );
                }*/
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
