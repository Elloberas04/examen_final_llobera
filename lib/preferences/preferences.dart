import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static bool loginFet = false;
  static String correu = '';
  static String contrasenya = '';
  static bool recordar = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get loginDone {
    return _prefs.getBool('loginFet') ?? false;
  }

  static set loginDone(bool value) {
    _prefs.setBool('loginFet', value);
  }

  static String get email {
    return _prefs.getString('correu') ?? '';
  }

  static set email(String value) {
    _prefs.setString('correu', value);
  }

  static String get password {
    return _prefs.getString('contrasenya') ?? '';
  }

  static set password(String value) {
    _prefs.setString('contrasenya', value);
  }

  static bool get remember {
    return _prefs.getBool('recordar') ?? false;
  }

  static set remember(bool value) {
    _prefs.setBool('recordar', value);
  }
}
