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
    return _preferences.getBool('session') ?? false;
  }

  set session(bool session){
    _preferences.setBool('session', session);
  }

  get profile{
    return _preferences.getString('profile');
  }

  set profile(String profile){
    _preferences.setString('profile', profile);
  }


}