import 'package:app19/database/entities/carboEntity.dart';
import 'package:app19/database/entities/puzzleEntity.dart';
import 'package:app19/others/numcal.dart';
import 'package:app19/others/numsteps.dart';
import 'package:app19/others/profile.dart';
import 'package:app19/others/carbohydrates.dart';
import 'package:app19/screens/carbolistUpdate.dart';
import 'package:app19/screens/editprofile.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:app19/screens/loginpage.dart';
import 'package:app19/screens/homepage.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:app19/repository/databaseRepository.dart';
import 'package:app19/database/database.dart';

Future<void> main() async{

  //This is a special method that use WidgetFlutterBinding to interact with the Flutter engine. 
  //This is needed when you need to interact with the native core of the app.
  //Here, we need it since when need to initialize the DB before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  //This opens the database.
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  //This creates a new DatabaseRepository from the AppDatabase instance just initialized
  final databaseRepository = DatabaseRepository(database: database);

  //Here, we run the app and we provide to the whole widget tree the instance of the DatabaseRepository. 
  //That instance will be then shared through the platform and will be unique.
  runApp(ChangeNotifierProvider<DatabaseRepository>(
    create: (context) => databaseRepository,
    child: MyApp(),
  ));
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
              ),
              ChangeNotifierProvider<numsteps>(
                create: (context) => numsteps(),
              ),
              ChangeNotifierProvider<numcal>(
                create: (context) => numcal(),
              ),
            ],
            child: MaterialApp(
              theme: theme,
              initialRoute: 'login',
              routes: {
                'login': (context) => LoginPage(),
                'home': (context) => HomePage(),
                'settings': (context) => Settings(title: 'Profile'),
                'carbolistUpdate': (context) => CarboListUpdate(),
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
            ElevatedButton(
              onPressed: () async{
                DateTime temp = DateTime.now();
                String dataString = temp.year.toString() + temp.month.toString() + temp.day.toString();
                carboEntity? check1 = await Provider.of<DatabaseRepository>(context,listen: false).check_carboEntity(dataString);
                print(check1);
                puzzleEntity? check2 = await Provider.of<DatabaseRepository>(context,listen: false).check_puzzleEntity(dataString);
                print(check2);
              }, 
              child: Text('prova funzionamento database')
              ),
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
