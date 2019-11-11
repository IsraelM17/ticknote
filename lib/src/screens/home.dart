import 'package:flutter/material.dart';
import 'package:ticknote/src/screens/rectangleOrange.dart';

class Home extends StatelessWidget with RectangleOrange {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final _appBar = Container(
      height: size.height * 0.12,
      width: size.width,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('TickNote', style: TextStyle(color: Colors.white),),
      ),
    );

    final _photoProfile = Positioned(
      right: size.width * 0.03,
      top:  size.height * 0.05,
      child: Container(
        height: size.height * 0.075,
        width: size.width * 0.2,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );

    final _bottomNavBar = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        height: size.height * 0.09,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white70,//Color.fromRGBO(255, 137, 60, 1).withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: size.height*0.01),
                Icon(Icons.home, color: Colors.black54,),
                Text('Inicio', style: TextStyle(color: Colors.black54))
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: size.height*0.01),
                Icon(Icons.format_list_bulleted, color: Colors.black54,),
                Text('Categorias', style: TextStyle(color: Colors.black54))
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: size.height*0.01),
                Icon(Icons.person_outline, color: Colors.black54, size: size.height * 0.03,),
                Text('Perfil', style: TextStyle(color: Colors.black54),)
              ],
            ),
            Container(),
            Container()
          ]
        )
      ),
    );

    final _floatingButton = MaterialButton(
      elevation: 7.0,
      splashColor: Colors.yellow.withOpacity(0.5),
      color: Color.fromRGBO(252, 111, 101, 1),
      child: Container(
        height: size.height* 0.09,
        width: size.width * 0.09,
        child: Icon(Icons.add, color: Colors.white, size: 40,),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      onPressed: () => print('Add'),
    );

    return Scaffold(
      body: Container(
        color: Color.fromRGBO(233, 233, 233, 1),
        height: size.height,
        width: size.width,
        child: Stack(
          children: <Widget>[

            Positioned(
              left: -50,
              child: rectangleOrange(context, size)
            ),
            Positioned(
              left: size.width * 0.33,
              top: -10,
              child: rectangleRed(context, size),
            ),

            _appBar,
            _photoProfile,
            _bottomNavBar

          ],
        ),
      ),

      floatingActionButton: _floatingButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }
}