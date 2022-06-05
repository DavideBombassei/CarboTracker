import 'package:app19/database/entities/carboEntity.dart';
import 'package:flutter/material.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:app19/repository/databaseRepository.dart';
import 'package:provider/provider.dart';

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
              labelText: 'Enter username',
              hintText: 'username',
            ),
          ),
          TextField(
            controller: _pswcontroller,
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'Enter password', hintText: 'password'),
          ),
          ElevatedButton(
            child: Text('Submit'),
            onPressed: () async{
              //if (_usercontroller.value.text == 'anna_arnaudo' && _pswcontroller.value.text == 'Biowrbl19'){
              if (_usercontroller.value.text == '' &&
                  _pswcontroller.value.text == '') {
                Navigator.pushNamed(context, 'home');
                String? userId = await FitbitConnector.authorize(
                  context: context,
                  clientID: '238CL6',
                  clientSecret: '9ba8e03acc6170c27f5654037ee7a13a',
                  redirectUri: 'example://fitbit/auth',
                  callbackUrlScheme: 'example');
                DateTime temp = DateTime.now();
                String dataString = temp.year.toString() + temp.month.toString() + temp.day.toString();
                carboEntity? check = await Provider.of<DatabaseRepository>(context,listen: false).check_carboEntity(dataString);
                if (check == null){
                  await Provider.of<DatabaseRepository>(context,listen: false).insert_carboEntity(carboEntity(null, dataString, 0, 0, 0, 0));
                  print('Memorizzando il giorno...');
                }
                else{
                  print('Giorno già memorizzato');
                }
              } 
              else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Wrong credentials')));
              }
            },
          ),
          ElevatedButton(
            onPressed: () async{
              await Provider.of<DatabaseRepository>(context,listen: false).delete_all();
            },
            child: Text('cancella database'),
          ),
        ],
      ),
    );
  }
}
