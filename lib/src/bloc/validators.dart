import 'dart:async';

class Validators{

  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){

      Pattern patternEmail  = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp         = RegExp(patternEmail);

      if( regExp.hasMatch(email) ) {
        sink.add(email);
      } else {
        sink.addError('Correo inválido');
      }

    }
  );

  final validaPassword = StreamTransformer<String, String>.fromHandlers(

    handleData: (password, sink){

      if( password.length >= 6 ) {
        sink.add(password);
      } else {
        sink.addError('Contraseña inválida');
      }

    }

  );

}