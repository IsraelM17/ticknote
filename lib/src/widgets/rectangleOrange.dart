import 'dart:math';

import 'package:flutter/material.dart';

class RectangleOrange{

  Widget rectangleOrange(BuildContext context, Size size){

    return Transform.rotate(

        angle: pi / 5.0,
        child: Container(

        height: size.height * 0.3,
        width: size.width * 0.7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 137, 60, 1),
              Color.fromRGBO(255, 165, 69, 1)
            ],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter
          ),
          borderRadius: BorderRadius.circular(30)
        ),

      ),
    );

  }

  Widget rectangleRed(BuildContext context, Size size){

    return Transform.rotate(

        angle: pi / 5.0,
        child: Container(

        height: size.height * 0.15,
        width: size.width * 0.35,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(237, 106, 40, 1),
              Color.fromRGBO(253, 117, 46, 1)
            ],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter
          ),
          borderRadius: BorderRadius.circular(20)
        ),

      ),
    );

  }

  Widget rectangleOrangeLarge(BuildContext context, Size size){

    return Container(

        height: size.height * 0.35,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 137, 60, 1),
              Color.fromRGBO(255, 165, 69, 1)
            ],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter
          ),
          borderRadius: BorderRadius.circular(30)
        ),


    );

  }

  Widget rectangleRedLarge(BuildContext context, Size size){

    return Container(

        height: size.height * 0.05,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(237, 106, 40, 1),
              Color.fromRGBO(253, 117, 46, 1)
            ],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter
          ),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
        ),


    );
  }

}