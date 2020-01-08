import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticknote/src/bloc/provider.dart';
import 'package:ticknote/src/firebase/auth.dart';
import 'package:ticknote/src/firebase/firestoredb.dart';
import 'package:ticknote/src/preferences/userPreferences.dart';
import 'package:ticknote/src/screens/addCard.dart';
import 'package:ticknote/src/screens/addNote.dart';
import 'package:ticknote/src/screens/login.dart';
import 'package:ticknote/src/screens/splashScreen.dart';
import 'package:ticknote/src/screens/home.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final preferences = new UserPreferences();
  final fireAuth   = new Auth();
  final firestore  = new FirestoreDB();

  fireAuth.initAuth();
  firestore.initFirestoreDB();
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
          textTheme: GoogleFonts.dosisTextTheme(Theme.of(context).textTheme,),
          primarySwatch: Colors.orange,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: TextTheme(title: GoogleFonts.varelaRound(fontSize: 25))
          ),
        ),
        initialRoute: preferences.session ? 'home' : 'login',
        routes: {
          'home'    : (BuildContext context) => Home(),
          'login'   : (BuildContext context) => Login(),
          'addNote' : (BuildContext context) => AddNote(),
          'addCard' : (BuildContext context) => AddCard(),
          'splash'  : (BuildContext context) => SplashScreen(),
        },
      ),
    );
  }
}