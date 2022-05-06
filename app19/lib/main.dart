import 'package:app19/others/profile.dart';
import 'package:app19/others/carbohydrates.dart';
import 'package:app19/screens/calendar.dart';
import 'package:app19/screens/carbolistUpdate.dart';
import 'package:app19/screens/editprofile.dart';
import 'package:app19/screens/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:app19/screens/loginpage.dart';
import 'package:app19/screens/homepage.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dark = ThemeData.dark();
    final darkButtonTheme =
        dark.buttonTheme.copyWith(buttonColor: Colors.grey[700]);
    final darkFABTheme = dark.floatingActionButtonTheme;

    final themeCollection = ThemeCollection(themes: {
      AppThemes.LightBlue: ThemeData(primarySwatch: Colors.blue),
      AppThemes.LightRed: ThemeData(primarySwatch: Colors.red),
      AppThemes.DarkBlue: ThemeData.from(
          colorScheme:
              ColorScheme.dark(primary: Colors.blue, secondary: Colors.blue)),
      AppThemes.DarkRed: ThemeData.from(
          colorScheme:
              ColorScheme.dark(primary: Colors.red, secondary: Colors.red)),
      AppThemes.LightGreen: ThemeData(primarySwatch: Colors.green),
      AppThemes.LightAmber: ThemeData(primarySwatch: Colors.amber),
      AppThemes.DarkGreen: ThemeData.from(
          colorScheme:
              ColorScheme.dark(primary: Colors.green, secondary: Colors.green)),
      AppThemes.DarkAmber: ThemeData.from(
          colorScheme:
              ColorScheme.dark(primary: Colors.amber, secondary: Colors.amber)),
    });

    // This widget is the root of your application.
    return DynamicTheme(
        themeCollection: themeCollection,
        defaultThemeId: AppThemes.LightBlue,
        builder: (context, theme) {
          //return ChangeNotifierProvider<carbohydrates>(
          //create: (context) => carbohydrates(),
          //return ChangeNotifierProvider<Profile>(
          //create: (context) => Profile(name: ' ', email: ' '),
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<carbohydrates>(
                create: (context) => carbohydrates(),
              ),
              ChangeNotifierProvider<Profile>(
                create: (context) => Profile(),
              )
            ],
            child: MaterialApp(
              theme: theme,
              initialRoute: 'login',
              routes: {
                'login': (context) => LoginPage(),
                'home': (context) => HomePage(),
                'calendar': (context) => Calendar(),
                'settings': (context) => Settings(title: 'Settings'),
                'carbolistUpdate': (context) => CarboListUpdate(),
                'profilepage': (context) => ProfilePage(),
                'editprofile': (context) => EditProfile(),
                'info': (context) => InfoPage(),
              },
            ),
          );
        });
  }
}

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InfoPage'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Inserire i Credits qui'),
          ],
        ),
      ),
    );
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
    );
  }
}
