import 'package:flutter/material.dart';
import 'package:restaurant/shared/shared_preferences.dart';

class Provider_Languages with ChangeNotifier{
  String lang = SharedPref().language ;
  void changeLanguage(String lang) {
    this.lang = lang ;
    notifyListeners() ;
  }
}