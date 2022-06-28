import 'package:app19/others/numcal.dart';
import 'package:app19/others/numsteps.dart';
import 'package:app19/others/profile.dart';
import 'package:app19/others/carbohydrates.dart';
import 'package:app19/screens/carbolistUpdate.dart';
import 'package:app19/screens/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:app19/screens/loginpage.dart';
import 'package:app19/screens/homepage.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:provider/provider.dart';
import 'package:app19/repository/databaseRepository.dart';
import 'package:app19/database/database.dart';
import 'others/infopage.dart';
import 'others/settings.dart';

Future<void> main() async {
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Here we define the variables used to store the theme informations
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
          //Here we return a MultiProvider widget, which contains the providers used to communicate with the other sections
          //of the app, and the MaterialApp widget in which we can find the routes of our application
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
              //We use the routes to navigate among the various pages of the app
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
