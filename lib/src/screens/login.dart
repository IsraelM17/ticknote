import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticknote/src/bloc/loginBloc.dart';
import 'package:ticknote/src/bloc/provider.dart';
import 'package:ticknote/src/screens/rectangleOrange.dart';

class Login extends StatelessWidget with RectangleOrange{
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final loginBloc = Provider.login(context);

    final formLogin = Container(
      height: size.height,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Column(
        children: <Widget>[
          SizedBox( height: size.height * 0.1),
          Text(
            'TickNote',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),

          SizedBox( height: size.height * 0.05),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.05),
            height: size.height * 0.45,
            width: size.width ,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey[100].withOpacity(0.5),
                  offset: Offset(7,10),
                  blurRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                _textUser(context, size, loginBloc),
                SizedBox(height: size.height * 0.04,),
                _textPassword(context, size, loginBloc),
                SizedBox(height: size.height * 0.04,),
                _buttonLogin(context, size, loginBloc)
              ],
            ),
          ),

          SizedBox( height: size.height * 0.1),

          Text('Ingresa mediante'),
          SizedBox(height: size.height * 0.01,),
          Container(
            height: size.height * 0.1,
            width: size.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.facebook, color: Color.fromRGBO(66, 103, 178, 1)),
                  iconSize: 60,
                  onPressed: () => Navigator.of(context).pushNamed('home'),
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.googlePlus, color: Color.fromRGBO(216, 77, 61, 1),),
                  iconSize: 60,
                  onPressed: () => print('Facebook'),
                )
              ],
            ),
          )

        ],
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(233, 233, 233, 1),
      body: Stack(
        children: <Widget>[

          rectangleOrangeLarge(context, size),
          Align( alignment: Alignment.bottomCenter, child: rectangleRedLarge(context, size),),
          formLogin

        ],
      ),
    );
  }

  Widget _textUser(BuildContext context, Size size, LoginBloc loginBloc){

    return StreamBuilder(
      stream: loginBloc.userStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(

          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'email',
              hintText: 'israel@mail.com',
              errorText: snapshot.error,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              )
            ),
            onChanged: (email) => loginBloc.changeUser(email),
          ),
        );

      },
    );

  }

  Widget _textPassword(BuildContext context, Size size, LoginBloc loginBloc){

    return StreamBuilder(
      stream: loginBloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return Container(
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              hintText: '',
              errorText: snapshot.error,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              )
            ),
            onChanged: (password) => loginBloc.changePassword(password),
          ),
        );

      },
    );

  }

  Widget _buttonLogin(BuildContext context, Size size, LoginBloc loginBloc){

    return StreamBuilder(
      stream: loginBloc.buttonLoginStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return RaisedButton(
          color: Colors.orange,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.2, vertical: size.height * 0.015),
            child: Text('Ingresar'),
          ),
          onPressed: snapshot.hasData ? () => Navigator.of(context).pushReplacementNamed('home') : null,
        );

      },
    );
  }

}