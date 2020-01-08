import 'package:rxdart/subjects.dart';

class CardBloc {

  final _numberController = BehaviorSubject<String>();
  final _dateController   = BehaviorSubject<String>();
  final _cvvController    = BehaviorSubject<String>();

  Stream<String> get numberStream => _numberController.stream;
  Stream<String> get dateStream   => _dateController.stream;
  Stream<String> get cvvStream    => _cvvController.stream;

  Function(String) get changeNumber => _numberController.sink.add;
  Function(String) get changeDate   => _dateController.sink.add;
  Function(String) get changeCvv    => _cvvController.sink.add;

  String get number => _numberController.value;
  String get date   => _dateController.value;
  String get cvv    => _cvvController.value;

  void dispose(){
  
    _numberController?.close();
    _dateController?.close();
    _cvvController?.close();
    
  }

}