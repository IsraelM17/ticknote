import 'package:flutter/material.dart';
import 'package:ticknote/src/bloc/provider.dart';
import 'package:ticknote/src/screens/login.dart';
import 'package:ticknote/src/screens/splashScreen.dart';
import 'package:ticknote/src/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        initialRoute: 'splash',
        routes: {
          'home'    : (BuildContext context) => Home(),
          'login'   : (BuildContext context) => Login(),
          'splash'  : (BuildContext context) => SplashScreen(),
        },
      ),
    );
  }
}