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
          glowColor: Theme.of(context).colorScheme.primary,
          endRadius: 100.0,
          child: Material(
            // Replace this child with your own
            elevation: 8.0,
            shape: CircleBorder(),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Image.asset('assets/images/profile5.png',
                  width: 400, height: 400),
              radius: 60.0,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Column(children: [
          Consumer<Profile>(builder: (context, Profile, child) {
            return Text('${profile.name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24));
          }),
          const SizedBox(height: 10),
          Consumer<Profile>(builder: (context, Profile, child) {
            return Text('${profile.email}',
                style: TextStyle(
                    color: Color.fromARGB(255, 121, 120, 120),
                    fontWeight: FontWeight.bold,
                    fontSize: 16));
          }),
          const SizedBox(height: 30),
          Consumer<Profile>(builder: (context, Profile, child) {
            return (profile.height == null || profile.weight == null)
                ? Text('')
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildButton(context, '${profile.height}', 'Height'),
                      buildDivider(context),
                      buildButton(context, '${profile.weight}', 'Weight'),
                      buildDivider(context),
                      buildButton(
                          context,
                          '${((profile.weight!) / ((profile.height!) * (profile.height!))).toStringAsFixed(2)}',
                          'BMI'),
                    ],
                  );
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
                : Container(
                    width: 290,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        new BoxShadow(
                          color: Theme.of(context).colorScheme.background,
                          offset: new Offset(6.0, 6.0),
                        ),
                      ],
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.cake),
                          Text(
                              //'Birthday: ${DateFormat('yyyy-MM-dd').format(profile.dateTime)}',
                              '    $birthday',
                              style: TextStyle(fontSize: 14))
                        ]));
          }),
          Consumer<Profile>(builder: (context, Profile, child) {
            return profile.height == null || profile.weight != null
                ? Text('')
                : Text('Height: ${profile.height}',
                    style: TextStyle(color: Colors.grey));
          }),
          const SizedBox(height: 30),
          Consumer<Profile>(builder: (context, Profile, child) {
            return profile.weight == null || profile.height != null
                ? Text('')
                : Text('Weight: ${profile.weight}',
                    style: TextStyle(color: Colors.grey));
          }),
          //_moreInformation(context)
        ]),
      ]);
}
//PER PRENDERE SPUNTO E FARLO PIU CARINO
//https://github.com/JohannesMilke/user_profile_ii_example/blob/master/lib/widget/numbers_widget.dart

Widget buildDivider(BuildContext context) => Container(
      height: 24,
      child: VerticalDivider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 2,
      ),
    );

Widget buildButton(BuildContext context, String value, String text) =>
    MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 4),
      onPressed: () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 2),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
