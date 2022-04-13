import 'package:app19/main.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: EditProfileState(),
    );
  }
}

class EditProfileState extends StatefulWidget {
  @override
  State<EditProfileState> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileState> {
  void _addCarbo10() {
    //funzione per aggiungere 10g
    setState(() {
      //carb += 10;
    });
  }

  final _name = 'Alessia';
  final _surname = 'Stefenato';
  final _email = 'mario.rossi@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(27.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarGlow(
              endRadius: 70.0,
              child: Material(
                // Replace this child with your own
                elevation: 8.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 192, 12, 12),
                  child: Image.asset('assets/images/logo.png',
                      width: 150, height: 150),
                  radius: 30.0,
                ),
              ),
            ),
            Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: '$_name $_surname',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: '$_email',
                  ),
                ),
                ElevatedButton(
                  child: Text('Save'),
                  onPressed: () {
                    //if (_usercontroller.value.text == 'anna_arnaudo' && _pswcontroller.value.text == 'Biowrbl19'){
                  },
                ),
              ],
            ),
          ]),
    );
  }
}
