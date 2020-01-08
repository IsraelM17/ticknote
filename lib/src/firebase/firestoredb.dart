import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB{

  static final FirestoreDB _instanceFirestore = FirestoreDB.internal();

  DocumentReference _reference;
  DocumentSnapshot  _snapshot;

  factory FirestoreDB(){
    return _instanceFirestore;
  }

  FirestoreDB.internal();

  Firestore _firestore;

  initFirestoreDB(){
    this._firestore = Firestore.instance;
  }

  Future<bool> addNote(String email, String title, String description, int color) async {

    try{

      _reference = _firestore.collection('users').document(email);

      _reference.setData({
        'notes' : FieldValue.arrayUnion([{
          'color'   : color,
          'title'   : title,
          'description' : description,
        }])
      }, merge: true);

      return true;

    }catch(e){
      print('error al agregar nota');
      return false;
    }

  }

  bool deleteNote(String email, Map note) {

    try{

      _reference = _firestore.collection('users').document(email);

      _reference.updateData({
        'notes' : FieldValue.arrayRemove([note])
      });

      print('se supone borro algo');
      return true;

    }catch(e){
      print('Error al eliminar nota: $e');
      return false;
    }

  }
  
}