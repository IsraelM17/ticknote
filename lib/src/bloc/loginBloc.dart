import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:ticknote/src/bloc/validators.dart';

class LoginBloc with Validators{

  final _userController     = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get userStream     => _userController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validaPassword);

  Stream<bool> get buttonLoginStream => Observable.combineLatest2(userStream, passwordStream, (e,p) => true);

  Function(String) get changeUser     => _userController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get user     => _userController.value;
  String get password => _passwordController.value;

  dispose(){

    _userController?.close();
    _passwordController?.close();

  }

}