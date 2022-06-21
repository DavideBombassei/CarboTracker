import 'package:app19/database/entities/carboEntity.dart';
import 'package:app19/database/entities/puzzleEntity.dart';
import 'package:flutter/material.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:app19/repository/databaseRepository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? profileName = 'Anna Arnaudo';
String? profileEmail = 'anna.arnaudo@gmail.com';
double? profileWeight = 62;
double? profileHeight = 1.62;
DateTime profileBirthday = DateTime(2000, 1, 1);

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPage'),
        centerTitle: true,
      ),
      body: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final _usercontroller = TextEditingController();
  final _pswcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(27.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _usercontroller,
            decoration: InputDecoration(
              labelText: 'Enter Username',
              hintText: 'Username',
            ),
          ),
          TextField(
            controller: _pswcontroller,
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'Enter Password', hintText: 'Password'),
          ),
          ElevatedButton(
            child: Text('Submit'),
            onPressed: () async {
              if (_usercontroller.value.text == 'user19' &&
                  _pswcontroller.value.text == 'demo19') {
                //if (_usercontroller.value.text == '' &&
                //_pswcontroller.value.text == '') {
                Navigator.pushNamed(context, 'home');
                String? userId = await FitbitConnector.authorize(
                    context: context,
                    clientID: '238CL6',
                    clientSecret: '9ba8e03acc6170c27f5654037ee7a13a',
                    redirectUri: 'example://fitbit/auth',
                    callbackUrlScheme: 'example');

                profileName = await getProfileName();
                profileEmail = await getProfileEmail();
                profileWeight = await getProfileWeight();
                profileHeight = await getProfileHeight();
                int profileBirthdayd = await getProfileBirthdayd();
                int profileBirthdaym = await getProfileBirthdaym();
                int profileBirthdayy = await getProfileBirthdayy();
                profileBirthday = DateTime(
                    profileBirthdayy, profileBirthdaym, profileBirthdayd);

                DateTime temp = DateTime.now();
                String dataString = temp.year.toString() +
                    temp.month.toString() +
                    temp.day.toString();
                carboEntity? check = await Provider.of<DatabaseRepository>(
                        context,
                        listen: false)
                    .check_carboEntity(dataString);
                if (check == null) {
                  await Provider.of<DatabaseRepository>(context, listen: false)
                      .insert_carboEntity(carboEntity(null, dataString, 0, 0, 0,
                          0, DateTime.now().hour, DateTime.now().hour));
                  await Provider.of<DatabaseRepository>(context, listen: false)
                      .insert_puzzleEntity(
                          puzzleEntity(null, dataString, 1, 1, false));
                  print('Memorizzando il giorno...');
                } else {
                  await Provider.of<DatabaseRepository>(context, listen: false)
                      .update_lastTimeRefreshed(
                          DateTime.now().hour, dataString);
                  print('Giorno già memorizzato');
                }
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Wrong credentials')));
              }
            },
          ),
        ],
      ),
    );
  }
}

Future<String> getProfileName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final profileName = prefs.getString('profileName') ?? 'Anna Arnaudo';
  return profileName;
}

Future<String> getProfileEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final profileEmail =
      prefs.getString('profileEmail') ?? 'anna.arnaudo@gmail.com';
  return profileEmail;
}

Future<double> getProfileWeight() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final profileWeight = prefs.getDouble('profileWeight') ?? 62;
  return profileWeight;
}

Future<double> getProfileHeight() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final profileHeight = prefs.getDouble('profileHeight') ?? 1.62;
  return profileHeight;
}

Future<int> getProfileBirthdayd() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final profileBirthdayd = prefs.getInt('profileBirthdayd');
  return profileBirthdayd ?? 1;
}

Future<int> getProfileBirthdaym() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final profileBirthdaym = prefs.getInt('profileBirthdaym');
  return profileBirthdaym ?? 1;
}

Future<int> getProfileBirthdayy() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final profileBirthdayy = prefs.getInt('profileBirthdayy');
  return profileBirthdayy ?? 2000;
}
