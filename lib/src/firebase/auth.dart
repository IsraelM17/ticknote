import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signIn(String email, String password) async{

    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      final FirebaseUser user = result.user;
      return true;
    } catch (e) {
      return false;
    }

  }

}