import 'package:flutter/material.dart';
import 'package:ticknote/src/bloc/provider.dart';
import 'package:ticknote/src/preferences/userPreferences.dart';
import 'package:ticknote/src/screens/login.dart';
import 'package:ticknote/src/screens/splashScreen.dart';
import 'package:ticknote/src/screens/home.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final preferences = new UserPreferences();
  await preferences.initPreferences();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final preferences = UserPreferences();
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TickNote',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white)
          )
        ),
        initialRoute: preferences.session ? 'home' : 'login',//splash',
        routes: {
          'home'    : (BuildContext context) => Home(),
          'login'   : (BuildContext context) => Login(),
          'splash'  : (BuildContext context) => SplashScreen(),
        },
      ),
    );
  }
}