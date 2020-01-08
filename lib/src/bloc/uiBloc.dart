import 'package:flutter/widgets.dart';
import 'package:rxdart/subjects.dart';

class UiBloc{

  final _tabIndexController = BehaviorSubject<int>();
  final _colorController    = BehaviorSubject<Color>();
  final _noteController     = BehaviorSubject<Map>();
  final _titleController    = BehaviorSubject<String>();
  final _descController     = BehaviorSubject<String>();

  Stream<int> get tabIndexStream  => _tabIndexController.stream;
  Stream<Color> get colorStream   => _colorController.stream;
  Stream<Map> get noteStream      => _noteController.stream;
  Stream<String> get titleStream  => _titleController.stream;
  Stream<String> get descStream   => _descController.stream;
  
  Function(int) get tabIndexChange  => _tabIndexController.sink.add;
  Function(Color) get colorChange   => _colorController.sink.add;
  Function(Map) get noteChange      => _noteController.sink.add;
  Function(String) get titleChange  => _titleController.sink.add;
  Function(String) get descChange   => _descController.sink.add;

  int get tabIndex  => _tabIndexController.value;
  Color get color   => _colorController.value;
  Map   get note    => _noteController.value;
  String get title  => _titleController.value;
  String get desc   => _descController.value;

  dispose(){
    _tabIndexController?.close();
    _colorController?.close();
    _noteController?.close();
    _titleController?.close();
    _descController?.close();
  }

}