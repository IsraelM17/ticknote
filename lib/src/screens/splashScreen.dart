import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _task();
  }

  ///Task for load splashScreen
  _task(){

    Timer(
      Duration(seconds: 4),
      () => Navigator.of(context).pushReplacementNamed('login')
    );

  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Color.fromRGBO(233, 233, 233, 1),
        height: size.height,
        width: size.width,
        child: Container(
          child: Column(
            children: <Widget>[

              SizedBox( height: size.height * 0.8 ),

              Container(
                height: size.height * 0.07,
                width: size.width * 0.3,
                child: FlareActor(
                  'assets/flare/loading_duration.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                  animation: 'loading',
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}