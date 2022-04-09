import 'package:flutter/material.dart';

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
            onPressed: () {
              //if (_usercontroller.value.text == 'anna_arnaudo' && _pswcontroller.value.text == 'Biowrbl19'){
              if (_usercontroller.value.text == '' &&
                  _pswcontroller.value.text == '') {
                Navigator.pushNamed(context, 'home');
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
