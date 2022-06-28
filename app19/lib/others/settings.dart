import 'package:app19/others/profile.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppThemes {
  static const int LightBlue = 0;
  static const int LightRed = 1;
  static const int DarkBlue = 2;
  static const int DarkRed = 3;
  static const int LightGreen = 4;
  static const int LightAmber = 5;
  static const int DarkGreen = 6;
  static const int DarkAmber = 7;

  static String toStr(int themeId) {
    switch (themeId) {
      case LightBlue:
        return "Light Blue";
      case LightRed:
        return "Light Red";
      case DarkBlue:
        return "Dark Blue";
      case DarkRed:
        return "Dark Red";
      case LightGreen:
        return "Light Green";
      case LightAmber:
        return "Light Amber";
      case DarkGreen:
        return "Dark Green";
      case DarkAmber:
        return "Dark Amber";
      default:
        return "Unknown";
    }
  }
}

class Settings extends StatefulWidget {
  final String title;

  const Settings({Key? key, required this.title}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int dropdownValue = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    dropdownValue = DynamicTheme.of(context)!.themeId;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          _visualProfile(context),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 12),
            child: Text('Select your theme here:'),
          ),
          DropdownButton(
              icon: Icon(Icons.arrow_downward),
              value: dropdownValue,
              items: [
                DropdownMenuItem(
                  value: AppThemes.LightBlue,
                  child: Text(AppThemes.toStr(AppThemes.LightBlue)),
                ),
                DropdownMenuItem(
                  value: AppThemes.LightRed,
                  child: Text(AppThemes.toStr(AppThemes.LightRed)),
                ),
                DropdownMenuItem(
                  value: AppThemes.LightGreen,
                  child: Text(AppThemes.toStr(AppThemes.LightGreen)),
                ),
                DropdownMenuItem(
                  value: AppThemes.LightAmber,
                  child: Text(AppThemes.toStr(AppThemes.LightAmber)),
                ),
                DropdownMenuItem(
                  value: AppThemes.DarkBlue,
                  child: Text(AppThemes.toStr(AppThemes.DarkBlue)),
                ),
                DropdownMenuItem(
                  value: AppThemes.DarkRed,
                  child: Text(AppThemes.toStr(AppThemes.DarkRed)),
                ),
                DropdownMenuItem(
                  value: AppThemes.DarkGreen,
                  child: Text(AppThemes.toStr(AppThemes.DarkGreen)),
                ),
                DropdownMenuItem(
                  value: AppThemes.DarkAmber,
                  child: Text(AppThemes.toStr(AppThemes.DarkAmber)),
                ),
              ],
              onChanged: (dynamic themeId) async {
                await DynamicTheme.of(context)!.setTheme(themeId);
                setState(() {
                  dropdownValue = themeId;
                });
              }),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.create),
          onPressed: () {
            Navigator.pushNamed(context, 'editprofile');
          }),
    );
  }
}

String birthday = '';
Widget _visualProfile(BuildContext context) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        AvatarGlow(
          glowColor: Theme.of(context).colorScheme.primary,
          endRadius: 100.0,
          child: Material(
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
                          Text('    $birthday', style: TextStyle(fontSize: 14))
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
        ]),
      ]);
}

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
