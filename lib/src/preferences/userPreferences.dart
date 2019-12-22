import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{

  static final UserPreferences _instancePreferences = UserPreferences.internal();


  factory UserPreferences(){
    return _instancePreferences;
  }

  UserPreferences.internal();

  SharedPreferences _preferences;

  initPreferences() async {
    this._preferences = await SharedPreferences.getInstance();
  }

  clearUserPreferences(){
    _preferences.clear();
  }

  get session{
    return _preferences.getBool('session') ?? 'login';
  }

  set session(bool session){
    _preferences.setBool('session', session);
  }

}