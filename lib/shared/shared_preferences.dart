import 'package:restaurant/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  //constructors that are private to the class
  SharedPref._internal() ;
  static final SharedPref _instance = SharedPref._internal();
  factory SharedPref(){
    return _instance ;
  }

  late SharedPreferences _prefs ;
  Future<void> initPreferences() async {
    _prefs = await SharedPreferences.getInstance() ;
  }

  // Save info the Acount
  Future<void> saveAcount({required User user}) async {
    await _prefs.setBool(preKey.login.toString(), user.login) ;
    await _prefs.setInt(preKey.id.toString(), user.id) ;
    await _prefs.setString(preKey.email.toString(), user.email);
    await _prefs.setString(preKey.passwored.toString(), user.password);
    await _prefs.setString(preKey.name.toString(), user.name);
  }
 // get info the acount
  bool get Login => _prefs.getBool(preKey.login.toString()) ?? false ;
  String get Email => _prefs.getString(preKey.email.toString()) ?? '' ;
  String get Name => _prefs.getString(preKey.name.toString()) ?? '' ;
  String get Passwored => _prefs.getString(preKey.passwored.toString()) ?? '' ;
  int get id => _prefs.getInt(preKey.id.toString()) ?? -1 ;

  // save language
  Future<void> saveLanguage({required String language }) async {
    await _prefs.setString(preKey.language.toString(), language );
  }
  // get language
  String get language => _prefs.getString(preKey.language.toString()) ?? 'en' ;

  // get any value in info the acount
  Object? get name => getValue( preKey.name.toString() ) ?? '' ;

  Object? getValue(String key){
    if(_prefs.containsKey(key)){
      return _prefs.get(key);
    }
    return null ;
  }

  Future<bool> clear() async {
    String lang = language ;
    bool clear = await _prefs.clear() ;
    saveLanguage(language: lang) ;
    return clear ;
  }
}

enum preKey{
  login,email,passwored,name ,id , language
}