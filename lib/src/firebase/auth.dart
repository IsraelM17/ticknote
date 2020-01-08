import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  static final Auth _instanceAuth = Auth.internal();

  factory Auth(){
    return _instanceAuth;
  }

  Auth.internal();

  FirebaseAuth _auth;

  initAuth(){
    this._auth = FirebaseAuth.instance;
  }

  Future<Map<String, dynamic>> signInEmail(String email, String password) async {

    try{
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;

      if(user.isEmailVerified) {
        return {
          "user" : { 
            'email' : email,
            'name'  : 'Israel Moreno',
            'photoUrl' : 'none'  
          }, 
          "message" : "loginOk"
        };
      }
      else
        return {"message" : "El correo no esta registrado"};

    }on PlatformException catch(e){
      switch(e.code){
        case 'ERROR_TOO_MANY_REQUEST':
          return {'message' : 'Demasiados intentos. Prueba más tarde'};
          break;
        case 'ERROR_WRONG_PASSWORD':
          return {'message':'La contraseña es incorrecta'};
          break;
        case 'ERROR_NETWORK_REQUEST_FAILED':
          return {'message':'Error de red'};
          break;
        default:
          return {'message':'Ups! Ocurrio un error. Intente más tarde'};
      }
    }

  }

  Future<bool> signOut() async {

    if ((await _auth.currentUser()) != null){

      await _auth.signOut();
      return true;

    }else{
      return false;
    }

  }

  Future<bool> createUser(String email, String password) async {

    try{
      
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;

    }catch(e){

    }

  }

}