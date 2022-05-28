import 'package:shared_preferences/shared_preferences.dart';


class Datastore {
  static late SharedPreferences _preferences;
  // initialization
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  // store data

  static Future storeflag (bool inputflag) async => await _preferences.setBool('flag', inputflag );


  // retrive data
  static bool? retriveflag() {
    return _preferences.getBool('flag');
  }

}