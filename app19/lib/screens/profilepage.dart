import 'package:app19/main.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:app19/screens/carbolist.dart';
import 'package:app19/others/profile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //Profile profile = Profile(name: 'mario', email: 'mario@gmail.com');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: _visualProfile(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.create),
          onPressed: () {
            Navigator.pushNamed(context, 'editprofile');
          }),

      /*Center(child: Consumer<Profile>(
        builder: (context, Profile, child) {
          return Text('${profile.name}');
        },
      )),*/
    );
  }
}

String birthday = '';
Widget _visualProfile(BuildContext context) {
  //developer.log('LOG:${_editProfile.name}');
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
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
        const SizedBox(height: 20),
        Column(children: [
          Consumer<Profile>(builder: (context, Profile, child) {
            return Text('Name: ${profile.name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24));
          }),
          const SizedBox(height: 30),
          Consumer<Profile>(builder: (context, Profile, child) {
            return Text('Email: ${profile.email}',
                style: TextStyle(color: Colors.grey));
          }),
          const SizedBox(height: 30),
          Consumer<Profile>(builder: (context, Profile, child) {
            //DateTime provDate = (DateTime) profile.dateTime;
            //DateFormat('yyyy-MM-dd').format(provDate);
            final format = DateFormat('dd-MM-yyyy');
            if (profile.dateTime != null) {
              birthday = format.format(profile.dateTime!);
            }
            return profile.dateTime == null
                ? Text('')
                : Text(
                    //'Birthday: ${DateFormat('yyyy-MM-dd').format(profile.dateTime)}',
                    'Birthday: $birthday',
                    style: TextStyle(color: Colors.grey));
          }),
          const SizedBox(height: 30),
          Consumer<Profile>(builder: (context, Profile, child) {
            return profile.height == null
                ? Text('')
                : Text('Height: ${profile.height}',
                    style: TextStyle(color: Colors.grey));
          }),
          const SizedBox(height: 30),
          Consumer<Profile>(builder: (context, Profile, child) {
            return profile.weight == null
                ? Text('')
                : Text('Weight: ${profile.weight}',
                    style: TextStyle(color: Colors.grey));
          }),
          //_moreInformation(context)
        ]),
      ]);
}
