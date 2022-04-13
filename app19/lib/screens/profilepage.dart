import 'package:app19/main.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Profile(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.create),
          onPressed: () {
            Navigator.pushNamed(context, 'editprofile');
          }),
    );
  }
}

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _addCarbo10() {
    //funzione per aggiungere 10g
    setState(() {
      //carb += 10;
    });
  }

  final _name = 'Mario Rossi';
  final _email = 'mario.rossi@gmail.com';
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(27.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarGlow(
                endRadius: 100.0,
                child: Material(
                  // Replace this child with your own
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 192, 12, 12),
                    child: Image.asset('assets/images/logo.png',
                        width: 400, height: 400),
                    radius: 60.0,
                  ),
                ),
              ),
              Column(children: [
                Text(
                  '$_name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 30),
                Text(
                  '$_email',
                  style: TextStyle(color: Colors.grey),
                )
              ]),
            ]));
  }
}