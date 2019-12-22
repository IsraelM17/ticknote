import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticknote/src/bloc/loginBloc.dart';
import 'package:ticknote/src/bloc/provider.dart';
import 'package:ticknote/src/firebase/auth.dart';
import 'package:ticknote/src/preferences/userPreferences.dart';
import 'package:ticknote/src/screens/rectangleOrange.dart';

class Login extends StatefulWidget with RectangleOrange{
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with RectangleOrange{

  bool _register  = false;
  bool _loading = false;

  TextEditingController _emailController  = TextEditingController();
  TextEditingController _passController   = TextEditingController(); 

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  final _userPreferences = UserPreferences();

  @override
  Widget build(BuildContext context) {
    
    final loginBloc = Provider.login(context);
    final size      = MediaQuery.of(context).size;

    final formLogin = Container(
      height: size.height,
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'TickNote',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),

            SizedBox( height: size.height * 0.05),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 7.0,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: StreamBuilder<int>(
                stream: loginBloc.choiceStream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  !snapshot.hasData ? loginBloc.changeOption(1) : null;
                  return Container(
                    height: snapshot.data == 1 ? size.height * 0.45 : size.height * 0.5,
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.05, horizontal: size.width * 0.04),
                    child: !_register ? _loginForm(context, size, loginBloc) : _registerForm(context, size, loginBloc)
                  );
                }
              ),
            ),

            SizedBox( height: size.height * 0.05),

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
                    iconSize: size.height * 0.06,
                    onPressed: () => Navigator.of(context).pushNamed('home'),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.google, color: Color.fromRGBO(216, 77, 61, 1),),
                    iconSize: size.height * 0.06,
                    onPressed: () => print('Facebook'),
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(233, 233, 233, 1),
      key: _globalKey,
      body: Stack(
        children: <Widget>[

          rectangleOrangeLarge(context, size),
          Align( alignment: Alignment.bottomCenter, child: rectangleRedLarge(context, size),),
          formLogin,
          _loading ? 
            Container( width: size.width, 
            height: size.height, 
            color: Colors.grey.withOpacity(0.5),
            child: Center(
              child: Container(
                height: size.height * 0.07,
                width: size.width * 0.3,
                child: FlareActor(
                  'assets/flare/loading_duration.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                  animation: 'loading',
                ),
              ),
            ),
          ) : Container()

        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context, Size size, LoginBloc loginBloc){

    return Column(
      children: <Widget>[
        _textUser(context, size, loginBloc),
        SizedBox(height: size.height * 0.02,),
        _textPassword(context, size, loginBloc),
        SizedBox(height: size.height * 0.02,),
        _buttonLogin(context, size, loginBloc),
        SizedBox(height: size.height * 0.02),
        _registerOrLogin(context, size, loginBloc)
      ],
    );

  }

  Widget _registerForm(BuildContext context, Size size, LoginBloc loginBloc){

    return Column(
      children: <Widget>[
        _textUser(context, size, loginBloc),
        SizedBox(height: size.height * 0.01,),
        _textPassword(context, size, loginBloc),
        SizedBox(height: size.height * 0.01,),
        _repeatPassword(context, size, loginBloc),
        SizedBox(height: size.height * 0.01,),
        _buttonRegister(context, size, loginBloc),
        SizedBox(height: size.height * 0.01),
        _registerOrLogin(context, size, loginBloc)
      ],
    );
  }

  Widget _textUser(BuildContext context, Size size, LoginBloc loginBloc){

    return StreamBuilder(
      stream: loginBloc.userStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(

          child: TextField(
            controller: _emailController,
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
        //print(snapshot.data);
        return Container(
          child: TextField(
            controller: _passController,
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

  Widget _repeatPassword(BuildContext context, Size size, LoginBloc loginBloc){

    return StreamBuilder(
      stream: loginBloc.repeatPStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirmar contrasenia',
              hintText: '',
              errorText: snapshot.data != loginBloc.password ? 'Las contrasenias no scoinciden' : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: snapshot.data != loginBloc.password ? Colors.red : Colors.green)
              )
            ),
            onChanged: (password) => loginBloc.changeRepeatP(password),
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
            borderRadius: BorderRadius.circular(10)
          ),
          child: Container(
            width: size.width,
            height: size.height * 0.05,
            child: Center(child: Text('Ingresar'),)
          ),
          onPressed: snapshot.hasData ? () => _login(_emailController.text, _passController.text) : null,
        );

      },
    );
  }

  Widget _buttonRegister(BuildContext context, Size size, LoginBloc loginBloc){

    return StreamBuilder(
      stream: loginBloc.buttonRegisterStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return RaisedButton(
          color: Colors.orange,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Container(
            width: size.width,
            height: size.height * 0.05,
            child: Center(child: Text('Registrarme'),)
          ),
          onPressed: snapshot.hasData ? () => Navigator.of(context).pushReplacementNamed('home') : null,
        );

      },
    );
  }

  Widget _registerOrLogin(BuildContext context, Size size, LoginBloc loginBloc){

    return Row(
      children: <Widget>[
        Expanded( 
          child: FlatButton(
            textColor: Color.fromRGBO(255, 151, 67, 1),
            child: Text('Iniciar sesion'),
            onPressed: _register ? (){ setState(() {
              _resetData(context, false);
              loginBloc.changeOption(1);
            });} : null,
          ),
        ),
        Expanded( 
          child: FlatButton(
            textColor: Color.fromRGBO(255, 151, 67, 1),
            child: Text('Registrarme'),
            onPressed: !_register ? () {setState(() {
              loginBloc.changeOption(2);
              _resetData(context, true);
            });} : null,
          )
        ),
      ],
    );

  }


  //! Revisar este coigo si funciona 
  _resetData(BuildContext context, bool register){

    final loginBloc = Provider.login(context);

    setState(() {
      _register = register;
      _emailController.clear();
      _passController.clear();
    });
  } 

  _login(String email, String password) async {

    setState(() {
      _loading = true;
    });

    bool isLogged = await Auth().signIn(email, password);

    if(isLogged){
      _loading = false;
      _userPreferences.session = true;
      Navigator.of(context).pushReplacementNamed('home');
    }
    else{
      _loading = false;
      _showSnackBar();
    }

    setState(() {});    
  }

  _showSnackBar(){
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      content: Text('Usuario y/o contrasenia incorrectos'),
    );
    _globalKey.currentState.showSnackBar(snackBar);
  }

}