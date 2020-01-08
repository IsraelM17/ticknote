import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:ticknote/src/bloc/validators.dart';

class LoginBloc with Validators{

  final _userController     = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _repeatPController  = BehaviorSubject<String>();
  final _optionController   = BehaviorSubject<int>();

  Stream<String> get userStream     => _userController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validaPassword);
  Stream<String> get repeatPStream  => _repeatPController.stream.transform(repeatPassword);
  Stream<int>    get choiceStream   => _optionController.stream;

  Stream<bool> get buttonLoginStream => Observable.combineLatest2(userStream, passwordStream, (e,p) => true);
  Stream<bool> get buttonRegisterStream => Observable.combineLatest3(userStream, passwordStream, repeatPStream, (e,p,t) => true);
  //Stream<String> get repeatPassStream => Observable.combineLatest2(streamA, streamB, combiner)
 
  Function(String) get changeUser     => _userController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeRepeatP  => _repeatPController.sink.add;
  Function(int)    get changeOption   => _optionController.sink.add;

  String get user     => _userController.value;
  String get password => _passwordController.value;
  String get repeatP  => _repeatPController.value;
  int get option   => _optionController.value;

  dispose(){

    _userController?.close();
    _passwordController?.close();
    _repeatPController?.close();
    _optionController?.close();

  }

}