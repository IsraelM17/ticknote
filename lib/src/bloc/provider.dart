import 'package:flutter/cupertino.dart';
import 'package:ticknote/src/bloc/cardBloc.dart';
import 'package:ticknote/src/bloc/loginBloc.dart';
import 'package:ticknote/src/bloc/uiBloc.dart';

class Provider extends InheritedWidget{

  static Provider _instancia;

  factory Provider({ Key key, Widget child }){
    if(_instancia == null){
      _instancia = new Provider._internal(key: key, child: child,);
    }

    return _instancia;
  }

  Provider._internal({ Key key, Widget child}) : super(key: key, child: child);

  final loginBloc = LoginBloc();
  final uiBloc    = UiBloc();
  final cardBloc  = CardBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc login(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).loginBloc;
  }

  static UiBloc ui(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).uiBloc;
  }

  static CardBloc card(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).cardBloc;
  }

}